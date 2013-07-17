require "spec_helper"

describe Uur::TablePrinting::TablePrinter do

  subject(:table_printer) { described_class.new(table, widths, alignments, out) }
  let(:out) { stub(:out) }

  describe "#print" do
    let(:table     ) { Uur::TablePrinting::Table.new(header, [ ["one", "two", "three"], ["four", "five", "six"] ]) }
    let(:header    ) { "The Header" }
    let(:widths    ) { [8, 6, 6] }
    let(:alignments) { [:left, :right, :right] }

    context "when all arguments are provided" do
      it "should print the table" do
        out.should_receive(:puts).with "The Header"
        out.should_receive(:puts).with ["one         two  three",
                                        "four       five    six"]
        table_printer.print
      end
    end

    context "when not all widths are provided" do
      let(:widths) { [8] }
      it "should assume the width that fits the content for each row differently" do
        out.should_receive(:puts).with "The Header"
        out.should_receive(:puts).with ["one      two three",
                                        "four     five six"]
        table_printer.print
      end
    end

    context "when not all alignments are provided" do
      let(:alignments) { [:left] }
      it "should assume the :left alignments" do
        out.should_receive(:puts).with "The Header"
        out.should_receive(:puts).with ["one      two    three",
                                        "four     five   six"]
        table_printer.print
      end
    end

    context "when provided widths are shorter than the cells content" do
      let(:widths) { [2, 1, 0] }
      it "should assume the width that fits the content for each row differently" do
        out.should_receive(:puts).with "The Header"
        out.should_receive(:puts).with ["one two three",
                                        "four five six"]
        table_printer.print
      end
    end

    context "when no header is provided" do
      let(:header) { nil }
      it "should not print the header line" do
        out.should_not_receive(:puts).with nil
        table_printer.print
      end
    end
  end
end
