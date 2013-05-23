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

      def print_tables(entries, interval, header_proc)
        Uur::TablePrinting::TablesPrinter.new(tables(entries, interval, header_proc), alignments, @out).print
      end

      def tables(entries, interval, header_proc)
        entries.group_by(&interval).map { |date, entries| Uur::TablePrinting::Table.new(header_proc.call(date), rows(entries)) }
      end
    end
  end
end
