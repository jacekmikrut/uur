module Uur
  module TablePrinting
    class Table < Array

      def initialize(header, *args)
        @header = header
        super(*args)
      end

      attr_accessor :header

      def ==(other)
        header == other.header && super
      end
    end
  end
end
