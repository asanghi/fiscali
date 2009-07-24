# Fiscali: Fiscal Year based calculations

Fiscali provides ONE thing:

 * Additional methods on your Date and Time classes to jump around dates in your Financial Year.
 * Not sure it's a point to be said, but YES, you can specify your financial year zone and if you dont know your zone, just provide the first month your financial year to the Date/Time class.

## Quick Links

 * [Wiki](http://wiki.github.com/asanghi/fiscali)
 * [Bugs](http://github.com/asanghi/fiscali/issues)
 * [Donate](http://pledgie.org/campaigns/5400)

## Installing

    # Install the gem:
    sudo gem install asanghi-fiscali
    
## Using in your Rails project

It's easy to get up and running. Update your config/environment.rb file with this gem

    config.gem "fiscali"

Next step is to provide your Date/Time class your start zone. Stick this in an initializer file. (If you didnt understand that, put it in $ENV[RAILS_ROOT]/config/initializers/fiscali.rb)

    Date.fiscal_zone = :india
    Time.fiscal_zone = :india
or
    Date.start_month = 4
    

### Default options

By default, the financial year start in January. (Correct me but thats not a common start of financial year!)
Known Zones are  -
    	{:india => 4, :uk => 4, :us => 10, :pakistan => 7,
         :australia => 7, :ireland => 1, :nz => 7, :japan => 4}

## Date or Time Class Methods
    
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

 
* financial_year
  Returns the financial year of the date/time
    Date.today.financial_year
    => 2009
    Date.today.beginning_of_year.financial_year
    => 2008
 Since 1st Jan 2009 in India falls in the 2008-09 financial year

* beginning_of_financial_year
  Returns the beginning of financial year
    Date.today.beginning_of_financial_year
    => 1st April 2009
    Date.today.beginning_of_year.beginning_of_financial_year
    => 1st April 2008

* end_of_financial_year

* beginning_of_financial_q1
* end_of_financial_q1

* beginning_of_financial_q2
* end_of_financial_q2

* beginning_of_financial_q3
* end_of_financial_q3

* beginning_of_financial_q4
* end_of_financial_q4

* beginning_of_financial_h1
* end_of_financial_h1

* beginning_of_financial_h2
* end_of_financial_h2

* financial_quarter
  Returns Q1, Q2, Q3, Q4 depending on where the date falls
	
    Date.today.financial_quarter
    => Q1
    Date.today.beginning_of_year.financial_quarter
    => Q4
  
* financial_half
  Returns H1, H2 depending on where the date falls
  
    Date.today.financial_half
    => H1
    Date.today.beginning_of_year.financial_half
    => H2
  
* next_financial_quarter
  Takes you to the beginning of the next financial quarter

    Date.today.next_financial_quarter
    => 1st July 2009
    
* next_financial_half
  Takes you to the beginning of the next financial half

    Date.today.next_financial_half
    => 1st October 2009

* beginning_of_financial_quarter
  Take you to the beginning of the current financial quarter

    Date.today.beginning_of_financial_quarter
    => 1st April 2009
    Date.today.beginning_of_year.beginning_of_financial_quarter
    => 1st Jan 2009

* beginning_of_financial_half
  Take you to the beginning of the current financial half

    Date.today.beginning_of_financial_half
    => 1st April 2009
    Date.today.beginning_of_year.beginning_of_financial_quarter
    => 1st Oct 2008

* previous_financial_quarter
  Take you to the beginning of the previous financial quarter

    Date.today.previous_financial_quarter
    => 1st Jan 2009
    Date.today.beginning_of_year.previous_financial_quarter
    => 1st Oct 2008

* previous_financial_half
  Take you to the beginning of the previous financial half

    Date.today.previous_financial_half
    => 1st Oct 2008
    Date.today.beginning_of_year.previous_financial_quarter
    => 1st Apr 2008
    

    



  
  


  
 
 