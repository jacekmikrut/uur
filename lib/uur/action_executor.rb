module Uur
  class ActionExecutor

    def initialize(options, entries)
      @options = options
      @entries = entries
    end

    def execute
      if @options[:print_summary]
        Printers::SummaryPrinter.new(duration_formatter).print(@entries.within(@options[:since], @options[:to]), @options[:summary_interval])

      elsif @options[:print_list]
        Printers::EntriesPrinter.new(duration_formatter).print(@entries.within(@options[:since], @options[:to]))

      end
    end

    private

    def duration_formatter
      case @options[:duration_format]
      when "hours-minutes"
        DurationFormatters::HoursAndMinutesDurationFormatter.new
      when "hours-decimal"
        DurationFormatters::HoursInDecimalNotationDurationFormatter.new
      else
        DurationFormatters::HoursAndMinutesDurationFormatter.new
      end
    end
  end
end
