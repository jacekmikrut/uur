require "spec_helper"

describe Uur::DurationFormatters::HoursAndMinutesDurationFormatter do

  subject(:duration_formatter) { described_class.new }

  describe "#format" do

    context "for 5 * 60" do
      it { duration_formatter.format(5 * 60).should eq " 5m" }
    end

    context "for 59 * 60" do
      it { duration_formatter.format(59 * 60).should eq "59m" }
    end

    context "for 60 * 60" do
      it { duration_formatter.format(60 * 60).should eq "1h00m" }
    end

    context "for (3 * 60 + 20) * 60" do
      it { duration_formatter.format((3 * 60 + 20) * 60).should eq "3h20m" }
    end

    context "for (40 * 60 + 20) * 60" do
      it { duration_formatter.format((40 * 60 + 20) * 60).should eq "40h20m" }
    end
  end
end
