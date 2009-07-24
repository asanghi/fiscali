module RisingSun
  module Fiscali
    def self.included(base)
      base.extend ClassMethods
      unless included_modules.include? InstanceMethods
        base.send(:include, InstanceMethods)
      end
    end

    FISCAL_ZONE = {:india => 4, :uk => 4, :us => 10, :pakistan => 7,
                   :australia => 7, :ireland => 1, :nz => 7, :japan => 4}
    FY_START_MONTH = 1

    module ClassMethods
      def fiscal_zone=(zone)
        write_inheritable_attribute(:start_month, FISCAL_ZONE[zone] || FY_START_MONTH)
        write_inheritable_attribute(:zone,zone)
      end

      def fy_start_month
        read_inheritable_attribute(:start_month)
      end

      def fiscal_zone
        read_inheritable_attribute(:zone)
      end

      def fy_start_month=(month)
      	write_inheritable_attribute(:zone, nil)
        write_inheritable_attribute(:start_month,month)
      end
    end

    module InstanceMethods
      def financial_year
        self.month < start_month ? self.year - 1 : self.year
      end

      def beginning_of_financial_year
        change(:year => financial_year, :month => start_month, :day => 1)
      end

      def end_of_financial_year
        (beginning_of_financial_year + 1.year - 1.month).end_of_month
      end

      alias :beginning_of_financial_q1 :beginning_of_financial_year
      def end_of_financial_q1
        end_of_financial_year - 9.months
      end

      def beginning_of_financial_q2
        beginning_of_financial_year + 3.months
      end

      def end_of_financial_q2
        end_of_financial_year - 6.months
      end

      def beginning_of_financial_q3
        beginning_of_financial_year + 6.months
      end

      def end_of_financial_q3
        end_of_financial_year - 3.months
      end

      def beginning_of_financial_q4
        beginning_of_financial_year + 9.months
      end
      alias :end_of_financial_q4 :end_of_financial_year

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

      def beginning_of_financial_quarter
        beginning_of_financial_year.months_since(((months_between / 3).floor) * 3)
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

      private

      def months_between
        soy = self.beginning_of_financial_year
        (self.month - soy.month) + 12 * (self.year - soy.year)
      end

      def start_month
        self.class.read_inheritable_attribute(:start_month) || FY_START_MONTH
      end

    end

  end
end
