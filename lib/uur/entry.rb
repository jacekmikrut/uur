require "ostruct"

module Uur
  class Entry < OpenStruct

    def day
      starts_at.beginning_of_day
    end

    def week
      starts_at.beginning_of_week
    end

    def month
      starts_at.beginning_of_month
    end

    def year
      starts_at.beginning_of_year
    end

    def duration
      (ends_at - starts_at).to_i
    end
  end
end
