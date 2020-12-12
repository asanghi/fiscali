module RisingSun
  module Fiscali
    def self.included(base)
      base.extend ClassMethods
    end

    FISCAL_ZONE = {:india => 4, :uk => 4, :us => 10, :pakistan => 7,
                   :australia => 7, :ireland => 1, :nz => 7, :japan => 4}
    FY_START_MONTH = 1

    module ClassMethods

      def fiscal_zone=(zone)
        @fiscali_start_month = FISCAL_ZONE[zone] || FY_START_MONTH
        @fiscali_zone = zone
      end

      def fy_start_month
        @fiscali_start_month || FY_START_MONTH
      end

      def fiscal_zone
        @fiscali_zone
      end

      def fy_start_month=(month)
        @fiscali_zone = nil
        @fiscali_start_month = month
      end

      def financial_year_start(year=Date.today.year)
        new(year,fy_start_month,1)
      end

      def financial_months
        (1..12).map{|m| ((m - 1 + fy_start_month)%12.1).ceil }
      end

      def use_forward_year!
        @fy_forward = true
      end

      def reset_forward_year!
        @fy_forward = false
      end

      def uses_forward_year?
        @fy_forward || false
      end

    end

    def financial_year
      if january_start_month?
        self.year
      elsif self.class.uses_forward_year?
        self.month < start_month ? self.year : self.year + 1
      else
        self.month < start_month ? self.year - 1 : self.year
      end
    end

    def beginning_of_financial_year
      change(:year => year_of_financial_year_beginning, :month => start_month, :day => 1).beginning_of_month
    end

    def end_of_financial_year
      (beginning_of_financial_year + 1.year - 1.month).end_of_month
    end

    (1..4).each do |q|
      define_method("beginning_of_financial_q#{q}"){ beginning_of_financial_quarter q }
      define_method("end_of_financial_q#{q}"){ end_of_financial_quarter q }
    end

    alias :beginning_of_financial_h1 :beginning_of_financial_year
    alias :end_of_financial_h1 :end_of_financial_q2

    alias :beginning_of_financial_h2 :beginning_of_financial_q3
    alias :end_of_financial_h2 :end_of_financial_year

    def financial_quarter
      "Q#{( months_between / 3 ).floor + 1} #{financial_year}"
    end

    def financial_half
      "H#{( months_between / 6 ).floor + 1} #{financial_year}"
    end

    def next_financial_quarter
      beginning_of_financial_year.months_since(((months_between / 3).floor + 1 ) * 3)
    end

    def next_financial_half
      beginning_of_financial_year.months_since(((months_between / 6).floor + 1) * 6)
    end

    def beginning_of_financial_quarter(quarter = nil)
      quarter = (months_between / 3).floor + 1 unless quarter.in? 1..4
      beginning_of_financial_year.advance(months: (quarter - 1) * 3).beginning_of_month
    end

    def end_of_financial_quarter(quarter = nil)
      quarter = (months_between / 3).floor + 1 unless quarter.in? 1..4
      beginning_of_financial_year.advance(months: quarter * 3 - 1).end_of_month
    end

    def beginning_of_financial_half
      beginning_of_financial_year.months_since(((months_between / 6).floor) * 6)
    end

    def previous_financial_quarter
      beginning_of_financial_quarter.months_ago(3)
    end

    def previous_financial_half
      beginning_of_financial_half.months_ago(6)
    end

    def all_financial_quarter
      beginning_of_financial_quarter..end_of_financial_quarter
    end

    def all_financial_year
      beginning_of_financial_year..end_of_financial_year
    end

    def financial_month_of(month)
      if month < start_month
        Date.new(year+1,month,1)
      else
        Date.new(year,month,1)
      end
    end

    private

    def year_of_financial_year_beginning
      if self.class.uses_forward_year? && !january_start_month?
        financial_year - 1
      else
        financial_year
      end
    end

    def january_start_month?
      start_month == 1
    end

    def months_between
      soy = self.beginning_of_financial_year
      (self.month - soy.month) + 12 * (self.year - soy.year)
    end

    def start_month
      self.class.fy_start_month || FY_START_MONTH
    end
  end
end
