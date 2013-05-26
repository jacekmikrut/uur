require "spec_helper"

describe Uur::DurationFormatters::HoursInDecimalNotationDurationFormatter do

  subject(:duration_formatter) { described_class.new }

  describe "#format" do

    context "for 5 * 60" do
      it { duration_formatter.format(5 * 60).should eq "0.08" }
    end

    context "for 59 * 60" do
      it { duration_formatter.format(59 * 60).should eq "0.98" }
    end

    context "for 60 * 60" do
      it { duration_formatter.format(60 * 60).should eq "1.00" }
    end

    context "for (3 * 60 + 20) * 60" do
      it { duration_formatter.format((3 * 60 + 20) * 60).should eq "3.33" }
    end

    context "for (40 * 60 + 20) * 60" do
      it { duration_formatter.format((40 * 60 + 20) * 60).should eq "40.33" }
    end
  end
end
