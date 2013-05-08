module Uur
  module Mixins
    module IntegerMixin

      def day
        self * 3600 * 24
      end

      alias_method :days, :day
    end
  end
end

Integer.send(:include, Uur::Mixins::IntegerMixin)
