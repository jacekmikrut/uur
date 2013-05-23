module Uur
  module Printers
    class Printer

      def initialize(duration_formatter, out=$stdout)
        @duration_formatter = duration_formatter
        @out = out
      end

      private

      def duration(duration)
        @duration_formatter.format(duration)
      end

      def print_tables(entries, interval, date_header_format)
        Uur::TablePrinting::TablesPrinter.new(tables(entries, interval, date_header_format), alignments, @out).print
      end

      def tables(entries, interval, date_header_format)
        entries.group_by(&interval).map { |date, entries| Uur::TablePrinting::Table.new("#{date.strftime(date_header_format)}", rows(entries)) }
      end
    end
  end
end
