require 'spec_helper'

describe "fiscali" do
  it "should be possible to read fiscal zone" do
    expect(Date.fiscal_zone).to be_nil
  end

  it "should be possible to write fiscal zone" do
    Date.fiscal_zone = :india
    expect(Date.fiscal_zone).to eql(:india)
  end

  it "should be possible to read fiscal start month" do
    Date.fy_start_month = 2
    expect(Date.fy_start_month).to eql(2)
  end

  it "should report financial year start" do
    Date.fiscal_zone = :india
    this_year = Date.today.year
    expect(Date.financial_year_start).to eql(Date.new(this_year,4,1))

    expect(Date.financial_year_start(2009)).to eql(Date.new(2009,4,1))
  end

  context "Forward Year settings" do
    after :each do
      Date.reset_forward_year!
    end

    it "should be possible to read year forward field" do
      expect(Date.uses_forward_year?).to eql(false)
    end

    it "should be possible to set year forward field" do
      Date.use_forward_year!
      expect(Date.uses_forward_year?).to eql(true)
    end

    it "should report the correct financial eyar if forward year is being used" do
      Date.use_forward_year!
      @d = Date.new(2009,1,1)
      expect(@d.financial_year).to eql(2009)
      @d = Date.new(2009,4,1)
      expect(@d.financial_year).to eql(2010)
    end

    it "should report the correct beginning_of_financial_year when forward year is set" do
      Date.use_forward_year!
      @d = Date.new(2009,6,1)
      expect(@d.beginning_of_financial_year).to eql(Date.new(2009,4,1))
    end
  end

  context "should report correct date field" do
    before :each do
      Date.fiscal_zone = :india
      @d = Date.new(2009,1,1)
    end

    it "should report correct financial year" do
      expect(@d.financial_year).to eql(2008)
    end

    it "should report correct beginning and of financial year" do
      expect(@d.beginning_of_financial_year).to eql(Date.new(2008,4,1))
      expect(@d.end_of_financial_year).to eql(Date.new(2009,3,31))
    end

    it "should report correct beginning of financial halves and quarters" do
      expect(@d.beginning_of_financial_h1).to eql(Date.new(2008,4,1))
      expect(@d.beginning_of_financial_h2).to eql(Date.new(2008,10,1))
      expect(@d.beginning_of_financial_q1).to eql(Date.new(2008,4,1))
      expect(@d.beginning_of_financial_q2).to eql(Date.new(2008,7,1))
      expect(@d.beginning_of_financial_q3).to eql(Date.new(2008,10,1))
      expect(@d.beginning_of_financial_q4).to eql(Date.new(2009,1,1))
    end

    it "should report correct end of financial halves and quarters" do
      expect(@d.end_of_financial_h1).to eql(Date.new(2008,9,30))
      expect(@d.end_of_financial_h2).to eql(Date.new(2009,3,31))
      expect(@d.end_of_financial_q1).to eql(Date.new(2008,6,30))
      expect(@d.end_of_financial_q2).to eql(Date.new(2008,9,30))
      expect(@d.end_of_financial_q3).to eql(Date.new(2008,12,31))
      expect(@d.end_of_financial_q4).to eql(Date.new(2009,3,31))

      Date.fiscal_zone = :us

      expect(@d.end_of_financial_h1).to eql(Date.new(2009,3,31))
      expect(@d.end_of_financial_h2).to eql(Date.new(2009,9,30))
      expect(@d.end_of_financial_q1).to eql(Date.new(2008,12,31))
      expect(@d.end_of_financial_q2).to eql(Date.new(2009,3,31))
      expect(@d.end_of_financial_q3).to eql(Date.new(2009,6,30))
      expect(@d.end_of_financial_q4).to eql(Date.new(2009,9,30))
    end

    it "should report financial quarters" do
      expect(@d.financial_quarter).to eql('Q4 2008')
    end

    it "should report financial half" do
      expect(@d.financial_half).to eql('H2 2008')
      expect(Date.new(2009, 11, 30).financial_half).to eql('H2 2009')
    end

    it "should report next half and quarter" do
      expect(@d.next_financial_half).to eql(Date.new(2009,4,1))
      expect(Date.new(2009,6,1).next_financial_half).to eql(Date.new(2009,10,1))

      expect(@d.next_financial_quarter).to eql(Date.new(2009,4,1))
      expect(Date.new(2009,10,30).next_financial_quarter).to eql(Date.new(2010,1,1))
    end

    it "should report beginning of financial half and quarter" do
      expect(@d.beginning_of_financial_half).to eql(Date.new(2008,10,1))
      expect(@d.beginning_of_financial_quarter).to eql(Date.new(2009,1,1))
      expect(Date.new(2009,6,1).beginning_of_financial_half).to eql(Date.new(2009,4,1))
      expect(Date.new(2009,10,30).beginning_of_financial_quarter).to eql(Date.new(2009,10,1))
    end

    it "should report previous financial half and quarter" do
      expect(@d.previous_financial_half).to eql(Date.new(2008,4,1))
      expect(@d.previous_financial_quarter).to eql(Date.new(2008,10,1))
      expect(Date.new(2009,6,1).previous_financial_half).to eql(Date.new(2008,10,1))
      expect(Date.new(2009,10,30).previous_financial_quarter).to eql(Date.new(2009,7,1))
    end

  end

  context "should report correct timestamp" do
    before(:each) do
      Time.fiscal_zone = :india
      @t = Time.new(2009,1,1,12,1,1)
    end

    it "should report beginning of year/half/quarter with timestamp at beginning of day" do
      expect(@t.beginning_of_financial_year).to eql(Time.new(2008,4,1,0,0,0))
      expect(@t.beginning_of_financial_h1).to eql(Time.new(2008,4,1,0,0,0))
      expect(@t.beginning_of_financial_h2).to eql(Time.new(2008,10,1,0,0,0))
      expect(@t.beginning_of_financial_q1).to eql(Time.new(2008,4,1,0,0,0))
      expect(@t.beginning_of_financial_q2).to eql(Time.new(2008,7,1,0,0,0))
      expect(@t.beginning_of_financial_q3).to eql(Time.new(2008,10,1,0,0,0))
      expect(@t.beginning_of_financial_q4).to eql(Time.new(2009,1,1,0,0,0))
    end

    it "should report end of year/half/quarter with timestamp at end of day" do
      expect(@t.end_of_financial_year).to eql(Time.new(2009,3,31).end_of_day)
      expect(@t.end_of_financial_h1).to eql(Time.new(2008,9,30).end_of_day)
      expect(@t.end_of_financial_h2).to eql(Time.new(2009,3,31).end_of_day)
      expect(@t.end_of_financial_q1).to eql(Time.new(2008,6,30).end_of_day)
      expect(@t.end_of_financial_q2).to eql(Time.new(2008,9,30).end_of_day)
      expect(@t.end_of_financial_q3).to eql(Time.new(2008,12,31).end_of_day)
      expect(@t.end_of_financial_q4).to eql(Time.new(2009,3,31).end_of_day)
    end
  end

  it "should not rely on app being single threaded" do
    Date.fiscal_zone = :india
    thread = Thread.new { Thread.current["my_fiscal_zone"] = Date.fiscal_zone }
    thread.join
    expect(thread['my_fiscal_zone']).to eql(:india)
  end

  context "when the start month is January" do
    around :each do |example|
      old_fy_start_month = Date.fy_start_month
      Date.fy_start_month = 1
      @date = Date.new(2014, 1, 1)
      example.run
      Date.fy_start_month = old_fy_start_month
    end

    it "returns the date's year as the financial year" do
      expect(@date.financial_year).to eql(2014)
    end

    context "when using forward year" do
      around :each do |example|
        Date.use_forward_year!
        example.run
        Date.reset_forward_year!
      end

      it "returns the date's year as the financial year" do
        expect(@date.financial_year).to eql(2014)
      end

      it "returns the date itself as the beginning_of_financial_year" do
        expect(@date.beginning_of_financial_year).to eql(@date)
      end

      it "returns the date itself as the end_of_financial_year" do
        expect(@date.end_of_financial_year).to eql(Date.new(2014, 12, 31))
      end
    end
  end
end
