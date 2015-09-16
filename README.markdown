# Fiscali: Fiscal Year based calculations

Fiscali provides methods on your Date and Time classes to jump around dates in your Financial Year.

You can specify your financial year zone and if you don’t know your zone, just provide the month your financial year begins.

## Quick Links

 * [Wiki](https://github.com/asanghi/fiscali/wiki)
 * [Bugs](https://github.com/asanghi/fiscali/issues)
 * [Donate](https://pledgie.org/campaigns/5400)

## Installing

    gem install fiscali

## Using in your Rails project

In Rails projects, include Fiscali in the Gemfile, and run `bundle install` to install the gem:

    gem 'fiscali'

Next, create an initializer for configuration Fiscali:

    config/initializers/fiscali.rb

Either provide your Date/Time class your start zone:

    Date.fiscal_zone = :india

Or if set the exact start month—for example, April:

    Date.fy_start_month = 4

You can also determine the default for Year Forward by adding this to the same initializer file:

    Date.use_forward_year!
    Time.use_forward_year!

To revert back to the default:

    Date.reset_forward_year!
    Time.reset_forward_year!

“Year Forward” refers to the standard name for a fiscal year. For example:

* If FY 2008 spans 2008–2009, set to false or don’t include in initializer file.
* If FY 2008 spans 2007–2008, set to true in initializer file.

Note that for every configuration you make, you will need to make it to every class (Date, Time, and DateTime) independently. For example:

    Date.fiscal_zone = :india
    Time.fiscal_zone = :india
    DateTime.fiscal_zone = :india

### Default options

By default, the financial year start in January.

Supported zones are:

    { india: 4, uk: 4, us: 10, pakistan: 7, australia: 7, ireland: 1, nz: 7, japan: 4}

By default, the year forward is false, meaning the term FY 2008 spans 2008–2009 years.

## Date or Time Class Methods

### Fiscal Zone and FY Start Month

    Date.fy_start_month
    => 1
    Date.fiscal_zone = :india
    => :india
    Date.fy_start_month
    => 4
    Date.fiscal_zone
    => :india
    Date.fy_start_month = 7
    => 7
    Date.fy_start_month
    => 7
    Date.fiscal_zone
    => nil

#### Year Forward (Assume Date.today is 1st May 2009 and the fy_start_month = 4)

    Date.uses_forward_year?
    => false
    Date.today.financial_year
    => 2009

    Date.use_forward_year!
    => true
    Date.today.financial_year
    => 2010
    Date.uses_forward_year?
    => true

If you want to add your own fiscal zone

    RisingSun::Fiscali::FISCAL_ZONE.merge!(:my_own_zone => 2)

should do the trick.

## Date or Time Instance Methods

    Date.fiscal_zone = :india
    => :india
    Date.fy_start_month
    => 4

Indian Fiscal Year starts from 1st of April
Assume Date.today is 1st May 2009

##### financial_year -> Returns the financial year of the date/time

    Date.today.financial_year
    => 2009
    Date.today.beginning_of_year.financial_year
    => 2008

Since 1st Jan 2009 in India falls in the 2008-09 financial year

##### beginning_of_financial_year -> Returns the beginning of financial year

    Date.today.beginning_of_financial_year
    => 1st April 2009
    Date.today.beginning_of_year.beginning_of_financial_year
    => 1st April 2008

##### end_of_financial_year

##### beginning_of_financial_q1
##### end_of_financial_q1

##### beginning_of_financial_q2
##### end_of_financial_q2

##### beginning_of_financial_q3
##### end_of_financial_q3

##### beginning_of_financial_q4
##### end_of_financial_q4

##### beginning_of_financial_h1
##### end_of_financial_h1

##### beginning_of_financial_h2
##### end_of_financial_h2

##### financial_quarter -> Returns Q1, Q2, Q3, Q4 depending on where the date falls

    Date.today.financial_quarter
    => Q1 2009
    Date.today.beginning_of_year.financial_quarter
    => Q4 2009

##### financial_half -> Returns H1, H2 depending on where the date falls

    Date.today.financial_half
    => H1
    Date.today.beginning_of_year.financial_half
    => H2

##### next_financial_quarter -> Takes you to the beginning of the next financial quarter

    Date.today.next_financial_quarter
    => 1st July 2009

##### next_financial_half -> Takes you to the beginning of the next financial half

    Date.today.next_financial_half
    => 1st October 2009

##### beginning_of_financial_quarter -> Takes you to the beginning of a quarter in the current financial year (defaults to current quarter)

    Date.today.beginning_of_financial_quarter
    => 1st April 2009
    Date.today.beginning_of_year.beginning_of_financial_quarter
    => 1st Jan 2009
    Date.today.beginning_of_financial_quarter(3)
    => 1st July 2009

##### end_of_financial_quarter -> Takes you to the end of a quarter in the current financial year (defaults to current quarter)

    Date.today.end_of_financial_quarter
    => 30th June 2009
    Date.today.beginning_of_year.end_of_financial_quarter
    => 31st March 2009
    Date.today.end_of_financial_quarter(3)
    => 30th September 2009

##### beginning_of_financial_half -> Takes you to the beginning of the current financial half

    Date.today.beginning_of_financial_half
    => 1st April 2009
    Date.today.beginning_of_year.beginning_of_financial_quarter
    => 1st Oct 2008

##### previous_financial_quarter -> Takes you to the beginning of the previous financial quarter

    Date.today.previous_financial_quarter
    => 1st Jan 2009
    Date.today.beginning_of_year.previous_financial_quarter
    => 1st Oct 2008

##### previous_financial_half -> Takes you to the beginning of the previous financial half

    Date.today.previous_financial_half
    => 1st Oct 2008
    Date.today.beginning_of_year.previous_financial_quarter
    => 1st Apr 2008

## Contributors

* [@reed](https://github.com/reed)
* [@chiperific](https://github.com/chiperific)
* [@rshallit](https://github.com/rshallit)
* [@asanghi](https://github.com/asanghi)
