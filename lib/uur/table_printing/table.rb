module Uur
  module TablePrinting
    class Table < Array

      def initialize(header, *args)
        @header = header
        super(*args)
      end

      attr_accessor :header
    end
  end
end
