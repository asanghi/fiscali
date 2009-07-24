require 'test_helper'

class FiscaliTest < ActiveSupport::TestCase
  test "date test" do
    Date.fiscal_zone = :india
    assert_equal(Date.fiscal_zone,:india)
    assert_equal(Date.fy_start_month,4)
    Date.fy_start_month = 2
    assert_equal(Date.fy_start_month,2)

    Date.fiscal_zone = :india
    d = Date.new(2009,1,1)
    assert_equal(d.financial_year,2008,'Financial Year is not correct')
    assert_equal(d.beginning_of_financial_year,Date.new(2008,4,1),'Beginning of FY is not correct')
    assert_equal(d.beginning_of_financial_h1,Date.new(2008,4,1),'Beginning of h1 is not correct')
    assert_equal(d.beginning_of_financial_h2,Date.new(2008,10,1),'Beginning of h2 is not correct')
    assert_equal(d.beginning_of_financial_q1,Date.new(2008,4,1),'Beginning of q1 is not correct')
    assert_equal(d.beginning_of_financial_q2,Date.new(2008,7,1),'Beginning of q2 is not correct')
    assert_equal(d.beginning_of_financial_q3,Date.new(2008,10,1),'Beginning of q3 is not correct')
    assert_equal(d.beginning_of_financial_q4,Date.new(2009,1,1),'Beginning of q4 is not correct')

    assert_equal(d.end_of_financial_year,Date.new(2009,3,31),'End of FY is not correct')
    assert_equal(d.end_of_financial_h1,Date.new(2008,9,30),'End of h1 is not correct')
    assert_equal(d.end_of_financial_h2,Date.new(2009,3,31),'End of h2 is not correct')
    assert_equal(d.end_of_financial_q1,Date.new(2008,6,30),'End of q1 is not correct')
    assert_equal(d.end_of_financial_q2,Date.new(2008,9,30),'End of q2 is not correct')
    assert_equal(d.end_of_financial_q3,Date.new(2008,12,31),'End of q3 is not correct')
    assert_equal(d.end_of_financial_q4,Date.new(2009,3,31),'End of q4 is not correct')

    assert_equal(d.financial_quarter,'Q4 2008','Financial Quarter is not correct')
    assert_equal(Date.new(2008,4,1).financial_quarter,'Q1 2008','Financial Quarter is not correct')
    assert_equal(d.financial_half,'H2 2008','Financial Half is not correct')
    assert_equal(Date.new(2009,11,30).financial_half,'H2 2009','Financial Half is not correct')

    assert_equal(d.next_financial_half,Date.new(2009,4,1),'Next Financial Half is not correct')
    assert_equal(d.next_financial_quarter,Date.new(2009,4,1),'Next Financial Quarter is not correct')
    assert_equal(Date.new(2009,6,1).next_financial_half,Date.new(2009,10,1), 'Next Financial Half is not correct')
    assert_equal(Date.new(2009,10,30).next_financial_quarter,Date.new(2010,1,1),'Next Financial Quarter is not correct')

    assert_equal(d.beginning_of_financial_half,
                 Date.new(2008,10,1),'Beginning of Financial Half is not correct')
    assert_equal(d.beginning_of_financial_quarter,
                 Date.new(2009,1,1),'Beginning of Financial Quarter is not correct')
    assert_equal(Date.new(2009,6,1).beginning_of_financial_half,
                 Date.new(2009,4,1), 'Beginning of Financial Half is not correct')
    assert_equal(Date.new(2009,10,30).beginning_of_financial_quarter,
                 Date.new(2009,10,1),'Beginning of Financial Quarter is not correct')

    assert_equal(d.previous_financial_half,
                 Date.new(2008,4,1),'Previous Financial Half is not correct')
    assert_equal(d.previous_financial_quarter,
                 Date.new(2008,10,1),'Previous Financial Quarter is not correct')
    assert_equal(Date.new(2009,6,1).previous_financial_half,
                 Date.new(2008,10,1), 'Previous Financial Half is not correct')
    assert_equal(Date.new(2009,10,30).previous_financial_quarter,
                 Date.new(2009,7,1),'Previous Financial Quarter is not correct')
  end
end
