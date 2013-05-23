module Uur
  module Printers
    class EntriesPrinter < Printer

      def print(entries)
        print_tables entries, :day, proc { |time| time.strftime("%a, %d %B %Y") }
      end

      private

      def alignments
        [:left, :right, :left, :left]
      end

      def rows(entries)
        entries.map do |entry|
          ["#{entry.starts_at.strftime("%H:%M")} - #{entry.ends_at.strftime("%H:%M")}", "#{duration(entry.duration)}", "#{entry.project_name}", "#{entry.description}"]
        end.push(["       Total:", duration(entries.duration), "", ""])
      end
    end
  end
end
