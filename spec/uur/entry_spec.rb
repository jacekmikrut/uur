require "spec_helper"

describe Uur::Entry do

  describe "attributes" do
    subject(:entry) { Uur::Entry.new }
    let(:value) { stub(:value) }

    [:starts_at, :ends_at, :project_name, :description].each do |attr_name|

      it "should allow to set and get #{attr_name.inspect}" do
        entry.public_send "#{attr_name}=", value
        entry.public_send("#{attr_name}").should equal value
      end

      it "should allow to set #{attr_name.inspect} during initialization" do
        entry = Uur::Entry.new(attr_name => value)
        entry.public_send("#{attr_name}").should equal value
      end
    end
  end

  describe "#day" do
    subject { entry.day }

    context "for an entry that starts at 2013-05-11 10:28" do
      let(:entry) { Uur::Entry.new(starts_at: Time.new(2013, 5, 11, 10, 28)) }
      it { should eq Time.new(2013, 5, 11) }
    end
  end

  describe "#month" do
    subject { entry.month }

    context "for an entry that starts at 2013-05-11 10:28" do
      let(:entry) { Uur::Entry.new(starts_at: Time.new(2013, 5, 11, 10, 28)) }
      it { should eq Time.new(2013, 5) }
    end
  end

  describe "#year" do
    subject { entry.year }

    context "for an entry that starts at 2013-05-11 10:28" do
      let(:entry) { Uur::Entry.new(starts_at: Time.new(2013, 5, 11, 10, 28)) }
      it { should eq Time.new(2013) }
    end
  end

  describe "#duration" do
    subject { entry.duration }

    context "for an entry that starts at 2013-05-11 10:28 and ends at 2013-05-11 10:35" do
      let(:entry) { Uur::Entry.new(starts_at: Time.new(2013, 5, 11, 10, 28), ends_at: Time.new(2013, 5, 11, 10, 35)) }
      it { should eq 7 * 60 }
    end

    context "for an entry that starts at 2013-05-11 10:45 and ends at 2013-05-11 11:45" do
      let(:entry) { Uur::Entry.new(starts_at: Time.new(2013, 5, 11, 10, 45), ends_at: Time.new(2013, 5, 11, 11, 45)) }
      it { should eq 60 * 60 }
    end
  end
end
