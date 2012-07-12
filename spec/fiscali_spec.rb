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

  context "should report correct date field" do
    before(:each) do
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

  it "should not rely on app being single threaded" do
    Date.fiscal_zone = :india
    thread = Thread.new { Thread.current["my_fiscal_zone"] = Date.fiscal_zone }
    thread.join
    thread["my_fiscal_zone"].should == :india
  end

end