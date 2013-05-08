module Uur
  module Mixins
    module TimeMixin

      def beginning_of_day
        Time.new(year, month, day)
      end

      def end_of_day
        Time.new(year, month, day, 23, 59, 59)
      end

      def beginning_of_previous_day
        beginning_of_day - 1.day
      end

      def end_of_previous_day
        end_of_day - 1.day
      end

      def beginning_of_week
        (self - (wday - 1).days).beginning_of_day
      end

      def end_of_week
        (beginning_of_week + 7.days) - 1
      end

      def beginning_of_previous_week
        beginning_of_week - 7.days
      end

      def end_of_previous_week
        end_of_week - 7.days
      end

      def beginning_of_month
        Time.new(year, month)
      end

      def end_of_month
        Time.new(year + (month == 12 ? 1 : 0), month % 12 + 1) - 1
      end

      def beginning_of_previous_month
        Time.new(end_of_previous_month.year, end_of_previous_month.month)
      end

      def end_of_previous_month
        Time.new(year, month) - 1
      end

      def beginning_of_year
        Time.new(year)
      end

      def end_of_year
        Time.new(year + 1) - 1
      end

      def beginning_of_previous_year
        Time.new(year - 1)
      end

      def end_of_previous_year
        Time.new(year) - 1
      end
    end
  end
end

Time.send(:include, Uur::Mixins::TimeMixin)
