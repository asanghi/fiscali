require 'spec_helper'

describe "fiscali" do
  it "should be possible to read fiscal zone" do
    Date.fiscal_zone.should be_nil
  end

  it "should be possible to write fiscal zone" do
    Date.fiscal_zone = :india
    Date.fiscal_zone.should eql(:india)
  end

  it "should be possible to read fiscal start month" do
    Date.fy_start_month = 2
    Date.fy_start_month.should eql(2)
  end

  it "should report financial year start" do
    Date.fiscal_zone = :india
    this_year = Date.today.year
    Date.financial_year_start.should eql(Date.new(this_year,4,1))

    Date.financial_year_start(2009).should eql(Date.new(2009,4,1))
  end

  context "Forward Year settings" do
    after(:each) do
      Date.reset_forward_year!
    end

    it "should be possible to read year forward field" do
      Date.uses_forward_year?.should eql(false)
    end

    it "should be possible to set year forward field" do
      Date.use_forward_year!
      Date.uses_forward_year?.should eql(true)
    end

    it "should report the correct financial eyar if forward year is being used" do
      Date.use_forward_year!
      @d = Date.new(2009,1,1)
      @d.financial_year.should eql(2009)
      @d = Date.new(2009,4,1)
      @d.financial_year.should eql(2010)
    end

    it "should report the correct beginning_of_financial_year when forward year is set" do
      Date.use_forward_year!
      @d = Date.new(2009,6,1)
      @d.beginning_of_financial_year.should eql(Date.new(2009,4,1))
    end
  end

  context "should report correct date field" do
    before(:each) do
      Date.fiscal_zone = :india
      @d = Date.new(2009,1,1)
    end

    it "should report correct financial year" do
      @d.financial_year.should eql(2008)
    end

    it "should report correct beginning and of financial year" do
      @d.beginning_of_financial_year.should eql(Date.new(2008,4,1))
      @d.end_of_financial_year.should eql(Date.new(2009,3,31))
    end

    it "should report correct beginning of financial halves and quarters" do
      @d.beginning_of_financial_h1.should eql(Date.new(2008,4,1))
      @d.beginning_of_financial_h2.should eql(Date.new(2008,10,1))
      @d.beginning_of_financial_q1.should eql(Date.new(2008,4,1))
      @d.beginning_of_financial_q2.should eql(Date.new(2008,7,1))
      @d.beginning_of_financial_q3.should eql(Date.new(2008,10,1))
      @d.beginning_of_financial_q4.should eql(Date.new(2009,1,1))
    end

    it "should report correct end of financial halves and quarters" do
      @d.end_of_financial_h1.should eql(Date.new(2008,9,30))
      @d.end_of_financial_h2.should eql(Date.new(2009,3,31))
      @d.end_of_financial_q1.should eql(Date.new(2008,6,30))
      @d.end_of_financial_q2.should eql(Date.new(2008,9,30))
      @d.end_of_financial_q3.should eql(Date.new(2008,12,31))
      @d.end_of_financial_q4.should eql(Date.new(2009,3,31))

      Date.fiscal_zone = :us 

      @d.end_of_financial_h1.should eql(Date.new(2009,3,31))
      @d.end_of_financial_h2.should eql(Date.new(2009,9,30))
      @d.end_of_financial_q1.should eql(Date.new(2008,12,31))
      @d.end_of_financial_q2.should eql(Date.new(2009,3,31))
      @d.end_of_financial_q3.should eql(Date.new(2009,6,30))
      @d.end_of_financial_q4.should eql(Date.new(2009,9,30))
    end

    it "should report financial quarters" do
      @d.financial_quarter.should eql('Q4 2008')
    end

    it "should report financial half" do
      @d.financial_half.should eql('H2 2008')
      Date.new(2009,11,30).financial_half.should eql("H2 2009")
    end

    it "should report next half and quarter" do
      @d.next_financial_half.should eql(Date.new(2009,4,1))
      Date.new(2009,6,1).next_financial_half.should eql(Date.new(2009,10,1))

      @d.next_financial_quarter.should eql(Date.new(2009,4,1))
      Date.new(2009,10,30).next_financial_quarter.should eql(Date.new(2010,1,1))
    end

    it "should report beginning of financial half and quarter" do
      @d.beginning_of_financial_half.should eql(Date.new(2008,10,1))
      @d.beginning_of_financial_quarter.should eql(Date.new(2009,1,1))
      Date.new(2009,6,1).beginning_of_financial_half.should eql(Date.new(2009,4,1))
      Date.new(2009,10,30).beginning_of_financial_quarter.should eql(Date.new(2009,10,1))
    end

    it "should report previous financial half and quarter" do
      @d.previous_financial_half.should eql(Date.new(2008,4,1))
      @d.previous_financial_quarter.should eql(Date.new(2008,10,1))
      Date.new(2009,6,1).previous_financial_half.should eql(Date.new(2008,10,1))
      Date.new(2009,10,30).previous_financial_quarter.should eql(Date.new(2009,7,1))
    end

  end

  context "should report correct timestamp" do
    before(:each) do
      Time.fiscal_zone = :india
      @t = Time.new(2009,1,1,12,1,1)
    end

    it "should report beginning of year/half/quarter with timestamp at beginning of day" do
      @t.beginning_of_financial_year.should eql(Time.new(2008,4,1,0,0,0))
      @t.beginning_of_financial_h1.should eql(Time.new(2008,4,1,0,0,0))
      @t.beginning_of_financial_h2.should eql(Time.new(2008,10,1,0,0,0))
      @t.beginning_of_financial_q1.should eql(Time.new(2008,4,1,0,0,0))
      @t.beginning_of_financial_q2.should eql(Time.new(2008,7,1,0,0,0))
      @t.beginning_of_financial_q3.should eql(Time.new(2008,10,1,0,0,0))
      @t.beginning_of_financial_q4.should eql(Time.new(2009,1,1,0,0,0))
    end

    it "should report end of year/half/quarter with timestamp at end of day" do
      @t.end_of_financial_year.should eql(Time.new(2009,3,31).end_of_day)
      @t.end_of_financial_h1.should eql(Time.new(2008,9,30).end_of_day)
      @t.end_of_financial_h2.should eql(Time.new(2009,3,31).end_of_day)
      @t.end_of_financial_q1.should eql(Time.new(2008,6,30).end_of_day)
      @t.end_of_financial_q2.should eql(Time.new(2008,9,30).end_of_day)
      @t.end_of_financial_q3.should eql(Time.new(2008,12,31).end_of_day)
      @t.end_of_financial_q4.should eql(Time.new(2009,3,31).end_of_day)
    end
  end

  it "should not rely on app being single threaded" do
    Date.fiscal_zone = :india
    thread = Thread.new { Thread.current["my_fiscal_zone"] = Date.fiscal_zone }
    thread.join
    thread["my_fiscal_zone"].should == :india
  end

end