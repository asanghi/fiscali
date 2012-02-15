require 'date'
require 'active_support'
require 'active_support/core_ext'
require 'rising_sun/fiscali'
Date.send(:include, RisingSun::Fiscali)
Time.send(:include, RisingSun::Fiscali)
