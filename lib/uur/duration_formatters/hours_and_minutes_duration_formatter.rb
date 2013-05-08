module Uur
  module DurationFormatters
    class HoursAndMinutesDurationFormatter

      def format(duration)
        hours   = duration / 3600
        minutes = duration / 60 % 60
        hours > 0 ? "%dh%02dm" % [hours, minutes] : "%2dm" % [minutes]
      end
    end
  end
end
