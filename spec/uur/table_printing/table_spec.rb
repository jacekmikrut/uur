require "spec_helper"

describe Uur::TablePrinting::Table do

  subject(:table) { described_class.new(header, cells) }
  let(:header) { "Table Header" }
  let(:cells ) { [ ["a", "b"], ["c", "d"] ] }

  it { should be_kind_of Array }

  describe "#header and #header=" do
    it "should initially return the value set via the initialize method" do
      table.header.should equal header
    end

    it "should be the accessor" do
      new_header = "New Header"
      table.header = new_header
      table.header.should equal new_header
    end
  end
end
