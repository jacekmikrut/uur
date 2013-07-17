module Uur
  module TablePrinting
    class TablePrinter

      def initialize(table, widths, alignments, out=$stdout)
        @table      = table
        @widths     = widths
        @alignments = alignments
        @out        = out
      end

      def print
        @out.puts formatted_table.header unless formatted_table.header.nil?
        @out.puts formatted_table.map { |row_cells| row_cells.join(' ').rstrip }
      end

      private

      attr_reader :table, :widths, :alignments

      def formatted_table
        @formatted_table ||=
          Table.new(table.header, table.map do |cells_in_row|
            cells_in_row.each_with_index.map do |cell, column_index|
              cell.send({ :left => :ljust, :right => :rjust }[alignments[column_index] || :left], widths[column_index] || 0)
            end
          end)
      end
    end
  end
end
