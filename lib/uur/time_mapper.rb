module Uur
  class TimeMapper

    def initialize(now)
      @now = now
    end

    def since(time)
      case time
      when "today"      then @now.beginning_of_day
      when "yesterday"  then @now.beginning_of_previous_day
      when "this-week"  then @now.beginning_of_week
      when "last-week"  then @now.beginning_of_previous_week
      when "this-month" then @now.beginning_of_month
      when "last-month" then @now.beginning_of_previous_month
      when "this-year"  then @now.beginning_of_year
      when "last-year"  then @now.beginning_of_previous_year
      end
    end

    def to(time)
      case time
      when "today"      then @now.end_of_day
      when "yesterday"  then @now.end_of_previous_day
      when "this-week"  then @now.end_of_week
      when "last-week"  then @now.end_of_previous_week
      when "this-month" then @now.end_of_month
      when "last-month" then @now.end_of_previous_month
      when "this-year"  then @now.end_of_year
      when "last-year"  then @now.end_of_previous_year
      end
    end
  end
end
