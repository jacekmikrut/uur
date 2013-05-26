require "optparse"

module Uur
  class ArgsParser

    def parse(args)
      options = {}

      OptionParser.new do |opts|
        opts.banner = "Usage: uur [options]"

        opts.separator ""
        opts.separator "Reports:"

        opts.on "-l", "--list", "List entries" do
          options[:print_list] = true
        end

        opts.on "-s", "--summary [daily|weekly|monthly|yearly|all]", "Print summary" do |value|
          options[:print_summary] = true
          options[:summary_interval] = value
        end

        opts.separator ""
        opts.separator "Filtering:"

        opts.on "-w", "--within today|yesterday|this-week|last-week|this-month|last-month|this-year|last-year", String, "Time period (default: today)" do |value|
          options[:within] = value
        end

        opts.separator ""
        opts.separator "Common options:"

        opts.on "-d", "--duration-format hours-minutes|hours-decimal", String, "Duration time format (default: hours-minutes)" do |value|
          options[:duration_format] = value
        end

        opts.separator ""
        opts.separator "Others:"

        opts.on_tail "-h", "--help", "Show this help message" do
          puts opts
          exit
        end

        opts.on_tail "--version", "Show version" do
          puts "uur version #{Uur::VERSION}"
          exit
        end

      end.parse!(args)

      options[:within         ] ||= "today" if options[:summary_interval].nil?
      options[:duration_format] ||= "hours-minutes"
      options[:print_list     ]   = true if !options[:print_list] && !options[:print_summary]

      set_default_summary_interval(options) if options[:print_summary] && options[:summary_interval].nil?

      if options[:within]
        time_mapper = TimeMapper.new(Time.now)
        options[:since] = time_mapper.since(options[:within])
        options[:to   ] = time_mapper.to(   options[:within])
      end

      options
    end

    private

    def set_default_summary_interval(options)
      options[:summary_interval] = case options[:within]
                                   when "today", "yesterday"
                                     "daily"
                                   when "this-week", "last-week"
                                     "weekly"
                                   when "this-month", "last-month"
                                     "monthly"
                                   when "this-year", "last-year"
                                     "yearly"
                                   end
    end
  end
end
