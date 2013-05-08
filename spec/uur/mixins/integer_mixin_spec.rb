require "spec_helper"

describe "Each integer after including", Uur::Mixins::IntegerMixin do

  subject(:integer) { 5 }

  it { should respond_to :day  }
  it { should respond_to :days }

  describe "#day/#days" do

    context "1.day" do
      it { 1.day.should  eq 3600 * 24 }
    end

    context "3.days" do
      it { 3.days.should eq 3600 * 24 * 3 }
    end
  end
end
