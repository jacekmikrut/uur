module Uur
  module Printers
    class NoEntriesMessagePrinter

      def initialize(within_option, out=$stdout)
        @within_option = within_option
        @out = out
      end

      def print
        @out.puts "No entries within #{within}."
      end

      private

      def within
        @within ||= @within_option.gsub(/-/, " ")
      end
    end
  end
end
