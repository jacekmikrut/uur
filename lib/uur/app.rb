module Uur
  class App

    def run
      ActionExecutor.new(ArgsParser.new.parse(ARGV), entries).execute
    rescue EntriesFileReader::CannotReadException => exception
      $stdout.puts exception.message
      $stdout.puts "Please make sure the file exists and is readable."
    end

    def data_dir
      @data_dir ||= File.expand_path("~/.uur")
    end

    def entries_file_path
      @entries_file_path ||= File.join(data_dir, "entries")
    end

    def entries_file_content
      @entries_file_content ||= EntriesFileReader.new(entries_file_path).read
    end

    def entries
      @entries ||= EntriesParser.new.parse(entries_file_content.lines)
    end
  end
end
