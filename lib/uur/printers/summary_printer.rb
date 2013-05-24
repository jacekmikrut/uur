module Uur
  module Printers
    class SummaryPrinter < Printer

      def print(entries, interval=nil)

        case interval
        when "daily"
          print_tables entries, :day,   proc { |time| time.strftime("%a, %d %B %Y") }

        when "weekly"
          print_tables entries, :week,  proc { |time| "#{time.beginning_of_week.strftime("%d %B %Y")} - #{time.end_of_week.strftime("%d %B %Y")}" }

        when "monthly"
          print_tables entries, :month, proc { |time| time.strftime("%B %Y") }

        when "yearly"
          print_tables entries, :year,  proc { |time| time.strftime("Year %Y") }

        else
          print_tables entries, :nil,   proc { |time| "All time summary" }

        end
      end

      private

      def alignments
        [:left, :right]
      end

      def rows(entries)
        entries.group_by(&:project_name).sort.map do |project_name, project_entries|
          [project_name, duration(project_entries.duration)]
        end.push(["Total:", duration(entries.duration)])
      end
    end
  end
end
