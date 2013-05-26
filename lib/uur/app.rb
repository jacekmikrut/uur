module Uur
  class App

    def run
      ActionExecutor.new(ArgsParser.new.parse(ARGV), entries).execute
    end

    def data_dir
      @data_dir ||= File.expand_path("~/.uur")
    end

    def entries_file_path
      @entries_file_path ||= File.join(data_dir, "entries")
    end

    def entries
      @entries ||= EntriesParser.new.parse(File.read(entries_file_path).lines)
    end
  end
end
