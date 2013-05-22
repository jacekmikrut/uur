require "time"

module Uur
  class EntriesParser

    REGEXP = /^\s*(?<date>[\d-]+)\s+(?<start_time>[\d:]+)\s*-\s*(?<end_time>[\d:]+)\s+(?<project_name>.*?)(?=\s\s|$)(?:\s\s+(?<description>.+)$)?/

    def parse(lines)
      reject_blank_or_commented_lines(lines).each_with_object(Entries.new) do |line, entries|
        entries << map_data_to_entry(line.match(REGEXP))
      end
    end

    private

    def reject_blank_or_commented_lines(lines)
      lines.reject do |line|
        line.strip == "" or line =~ /\s*#/
      end
    end

    def map_data_to_entry(data)
      Entry.new(
           starts_at: Time.strptime("#{data[:date]} #{data[:start_time]}", '%Y-%m-%d %H:%M'),
             ends_at: Time.strptime("#{data[:date]} #{data[  :end_time]}", '%Y-%m-%d %H:%M'),
        project_name: data[:project_name],
         description: (data[:description] || "").rstrip,
      )
    end
  end
end
