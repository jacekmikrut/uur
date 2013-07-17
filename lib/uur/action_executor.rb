module Uur
  class ActionExecutor

    def initialize(options, entries)
      @options = options
      @entries = entries
    end

    def execute
      if selected_entries.none?
        Printers::NoEntriesMessagePrinter.new(@options[:within]).print

      elsif @options[:print_summary]
        Printers::SummaryPrinter.new(duration_formatter).print(selected_entries, @options[:summary_interval])

      elsif @options[:print_list]
        Printers::EntriesPrinter.new(duration_formatter).print(selected_entries)

      end
    end

    private

    def selected_entries
      @selected_entries ||= @entries.within(@options[:since], @options[:to])
    end

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
