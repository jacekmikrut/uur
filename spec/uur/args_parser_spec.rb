require "spec_helper"

describe Uur::ArgsParser do

  describe "#parse" do
    subject { described_class.new.parse(args) }

    context "for %w[]" do
      let(:args) { %w[] }
      it { should == {
        print_list:       true,
        within:           "today",
        since:            Time.now.beginning_of_day,
        to:               Time.now.end_of_day,
        duration_format:  "hours-minutes"
      } }
    end

    context "for %w[-l]" do
      let(:args) { %w[-l] }
      it { should == {
        print_list:       true,
        within:           "today",
        since:            Time.now.beginning_of_day,
        to:               Time.now.end_of_day,
        duration_format:  "hours-minutes"
      } }
    end

    context "for %w[-l -w last-week]" do
      let(:args) { %w[-l -w last-week] }
      it { should == {
        print_list:       true,
        within:           "last-week",
        since:            Time.now.beginning_of_previous_week,
        to:               Time.now.end_of_previous_week,
        duration_format:  "hours-minutes"
      } }
    end

    context "for %w[-s]" do
      let(:args) { %w[-s] }
      it { should == {
        print_summary:    true,
        summary_interval: nil,
        within:           "today",
        since:            Time.now.beginning_of_day,
        to:               Time.now.end_of_day,
        duration_format:  "hours-minutes"
      } }
    end

    context "for %w[-s monthly]" do
      let(:args) { %w[-s monthly] }
      it { should == {
        print_summary:    true,
        summary_interval: "monthly",
        duration_format:  "hours-minutes"
      } }
    end

    context "for %w[-s weekly -w this-month -d hours-decimal]" do
      let(:args) { %w[-s weekly -w this-month -d hours-decimal] }
      it { should == {
        print_summary:    true,
        summary_interval: "weekly",
        within:           "this-month",
        since:            Time.now.beginning_of_month,
        to:               Time.now.end_of_month,
        duration_format:  "hours-decimal"
      } }
    end
  end
end
