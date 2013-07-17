module Uur
  class EntriesFileReader

    CannotReadException = Class.new(Exception)

    def initialize(entries_file_path)
      @entries_file_path = entries_file_path
    end

    def read
      File.read(@entries_file_path)
    rescue
      raise CannotReadException, "Cannot read the entries file: #{@entries_file_path}"
    end
  end
end
