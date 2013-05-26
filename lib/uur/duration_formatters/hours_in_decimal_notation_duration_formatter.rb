module Uur
  module DurationFormatters
    class HoursInDecimalNotationDurationFormatter

      def format(duration)
        "%0.2f" % (duration / 3600.0)
      end
    end
  end
end
