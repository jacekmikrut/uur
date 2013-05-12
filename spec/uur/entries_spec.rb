require "spec_helper"

describe Uur::Entries do

  it { should be_kind_of Array }

  describe "#within" do
    let(:entries) { Uur::Entries.new([entry_1, entry_2, entry_3, entry_4]) }
    let(:entry_1) { Uur::Entry.new(starts_at: Time.new(2013, 5, 10, 10, 15), ends_at: Time.new(2013, 5, 10, 10, 30)) }
    let(:entry_2) { Uur::Entry.new(starts_at: Time.new(2013, 5, 10, 10, 30), ends_at: Time.new(2013, 5, 10, 11, 10)) }
    let(:entry_3) { Uur::Entry.new(starts_at: Time.new(2013, 5, 10, 11, 30), ends_at: Time.new(2013, 5, 10, 12,  0)) }
    let(:entry_4) { Uur::Entry.new(starts_at: Time.new(2013, 5, 11,  9, 30), ends_at: Time.new(2013, 5, 11,  9, 50)) }

    it do
      entries.within(Time.new(2013, 5, 10, 10, 15), Time.new(2013, 5, 10, 12,  0)).should be_a Uur::Entries
    end

    it "should return entries that begin after or at the :since argument and end before or at the :to argument" do
      entries.within(Time.new(2013, 5, 10, 10, 15), Time.new(2013, 5, 10, 12,  0)).should == [entry_1, entry_2, entry_3]
    end

    it "should not return entries that are only partially included in the given range" do
      entries.within(Time.new(2013, 5, 10, 10, 20), Time.new(2013, 5, 10, 11, 40)).should == [entry_2]
    end
  end

  describe "#group_by" do
    subject(:result) { entries.group_by(&:project_name) }

    let(:entries ) { Uur::Entries.new([entry_A1, entry_B1, entry_A2, entry_C1]) }
    let(:entry_A1) { Uur::Entry.new(project_name: "Project A") }
    let(:entry_B1) { Uur::Entry.new(project_name: "Project B") }
    let(:entry_A2) { Uur::Entry.new(project_name: "Project A") }
    let(:entry_C1) { Uur::Entry.new(project_name: "Project C") }

    it "should group entries by values returned by the given block" do
      result.keys.should == ["Project A", "Project B", "Project C"]
      result["Project A"].should == [entry_A1, entry_A2]
      result["Project B"].should == [entry_B1]
      result["Project C"].should == [entry_C1]
    end

    specify "each grouped collection should be a kind of Uur::Entries" do
      result["Project A"].should be_kind_of Uur::Entries
      result["Project B"].should be_kind_of Uur::Entries
      result["Project C"].should be_kind_of Uur::Entries
    end
  end

  describe "#duration" do
    subject(:result) { entries.duration }

    let(:entries) { Uur::Entries.new([entry_1, entry_2, entry_3]) }
    let(:entry_1) { stub(:entry, duration: 10 * 60) }
    let(:entry_2) { stub(:entry, duration: 15 * 60) }
    let(:entry_3) { stub(:entry, duration:  5 * 60) }

    it "should return the sum of entries duration" do
      result.should eq 30 * 60
    end
  end
end
