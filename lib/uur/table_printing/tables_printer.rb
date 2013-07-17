module Uur
  module TablePrinting
    class TablesPrinter

      def initialize(tables, alignments, out=$stdout)
        @tables     = tables
        @alignments = alignments
        @out        = out
      end

      def print
        tables.each do |table|
          TablePrinter.new(table, widths, alignments, @out).print
          @out.puts
        end
      end

      private

      attr_reader :tables, :alignments

      def widths
        @widths ||= tables.flatten(1).transpose.map { |rows_in_column| rows_in_column.map(&:length).max }
      end
    end
  end
end
