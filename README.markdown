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

## APIs

