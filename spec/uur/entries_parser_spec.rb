require "spec_helper"

describe Uur::EntriesParser do

  describe "#parse" do
    subject(:result) { Uur::EntriesParser.new.parse(lines) }

    context "when there are only fields formatted strictly to the specification" do
      let(:lines) do
        [ "2013-05-12 10:00 - 10:30 Project Name  Entry description.",
          "2013-05-12 10:30 - 11:45 Project Name  Another entry description.",
          "2013-05-13 12:00 - 13:30 Another Project Name  Another entry description." ]
      end

      it "should return parsed entries" do
        result.size.should eq 3

        result[0].should be_kind_of Uur::Entry
        result[0].starts_at.should    eq Time.new(2013, 5, 12, 10,  0)
        result[0].ends_at.should      eq Time.new(2013, 5, 12, 10, 30)
        result[0].project_name.should eq "Project Name"
        result[0].description.should  eq "Entry description."

        result[2].should be_kind_of Uur::Entry
        result[2].starts_at.should    eq Time.new(2013, 5, 13, 12,  0)
        result[2].ends_at.should      eq Time.new(2013, 5, 13, 13, 30)
        result[2].project_name.should eq "Another Project Name"
        result[2].description.should  eq "Another entry description."
      end
    end

    context "if there are blank lines" do
      let(:lines) do
        [ "     ",
          "2013-05-12 10:00 - 10:30 Project Name  Entry description.",
          "" ]
      end

      specify "the blank lines should be ignored" do
        result.size.should eq 1
      end
    end

    context "if there are lines where the first non-whitespace character is #" do
      let(:lines) do
        [ "#2013-05-12 10:00 - 10:30 Project Name  Entry description.",
          "   # A comment" ]
      end

      specify "the commented lines should be ignored" do
        result.size.should eq 0
      end
    end

    context "if there is no description given" do
      let(:lines) { [ "2013-05-12 10:00 - 10:30 Project" ] }
      specify "the description should be an empty string" do
        result[0].description.should eq ""
      end
    end

    context "if the description is separated from the project name with only one space" do
      let(:lines) { [ "2013-05-12 10:00 - 10:30 Project Name Entry description." ] }
      specify "that description should be treated as a part of the project name" do
        result[0].project_name.should eq "Project Name Entry description."
      end
    end

    context "if the fields are surrounded by multiple whitespace characters" do
      let(:lines) { [ "   2013-05-12   10:00   -   10:30   Project Name   Entry description.   " ] }
      specify "the lines should still be parsed correctly" do
        result[0].starts_at.should    eq Time.new(2013, 5, 12, 10,  0)
        result[0].ends_at.should      eq Time.new(2013, 5, 12, 10, 30)
        result[0].project_name.should eq "Project Name"
        result[0].description.should  eq "Entry description."
      end
    end
  end
end
