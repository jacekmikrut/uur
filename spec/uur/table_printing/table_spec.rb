require "spec_helper"

describe Uur::TablePrinting::Table do

  subject(:table) { described_class.new(header, cells) }
  let(:header) { "Table Header" }
  let(:cells ) { [ ["a", "b"], ["c", "d"] ] }

  it { should be_kind_of Array }

  its(:inspect) { should eq "Header: \"Table Header\", content: [[\"a\", \"b\"], [\"c\", \"d\"]]" }

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

  describe "#==" do
    let(:other_table ) { described_class.new(other_header, other_cells) }

    context "when the other table has the same cells and the same header" do
      let(:other_header) { "Table Header" }
      let(:other_cells ) { [ ["a", "b"], ["c", "d"] ] }

      it { (table == other_table).should be_true }
    end

    context "when the other table has the same cells but different header" do
      let(:other_header) { "Different Header" }
      let(:other_cells ) { [ ["a", "b"], ["c", "d"] ] }

      it { (table == other_table).should be_false }
    end

    context "when the other table has the same header but different cells" do
      let(:other_header) { "Table Header" }
      let(:other_cells ) { [ ["a", "b"], ["c", "D"] ] }

      it { (table == other_table).should be_false }
    end
  end
end
