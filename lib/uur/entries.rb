module Uur
  class Entries < Array

    def within(since, to)
      self.class.new(select { |entry| (since.nil? || entry.starts_at >= since) && (to.nil? || entry.ends_at <= to) })
    end

    def group_by(&block)
      each_with_object(Hash.new { |hash, key| hash[key] = Entries.new }) { |entry, grouped| grouped[block.call(entry)] << entry }
    end

    def duration
      inject(0) { |total, entry| total + entry.duration }
    end
  end
end
