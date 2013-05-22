require "spec_helper"

describe Uur::TablePrinting::TablesPrinter do

  subject(:tables_printer) { described_class.new(tables, alignments, out) }
  let(:out) { stub(:out) }

  describe "#print" do
    let(:table_with_numbers ) { Uur::TablePrinting::Table.new("Numbers" , [ ["one"   , "two"    , "three"    ], ["four"    , "five"  , "six"     ] ]) }
    let(:table_with_weekdays) { Uur::TablePrinting::Table.new("Weekdays", [ ["Monday", "Tuesday", "Wednesday"], ["Thursday", "Friday", "Saturday"] ]) }
    let(:table_with_colors  ) { Uur::TablePrinting::Table.new("Colors"  , [ ["Red"   , "Green"  , "Blue"     ], ["White"   , "Gray"  , "Black"   ] ]) }
    let(:tables) { [table_with_numbers, table_with_weekdays, table_with_colors] }
    let(:alignments) { [] }

    it "should adjust the widths of all columns to the same size that fits the contents" do
      out.should_receive(:puts).with "Numbers"
      out.should_receive(:puts).with ["one      two     three    ",
                                      "four     five    six      "]
      out.should_receive(:puts).with no_args
      out.should_receive(:puts).with "Weekdays"
      out.should_receive(:puts).with ["Monday   Tuesday Wednesday",
                                      "Thursday Friday  Saturday "]
      out.should_receive(:puts).with no_args
      out.should_receive(:puts).with "Colors"
      out.should_receive(:puts).with ["Red      Green   Blue     ",
                                      "White    Gray    Black    "]
      out.should_receive(:puts).with no_args

      tables_printer.print
    end

    context "with custom alignments" do
      let(:alignments) { [:right, :left, :right] }

      it "should respect the custom alignments" do
        out.should_receive(:puts).with "Numbers"
        out.should_receive(:puts).with ["     one two         three",
                                        "    four five          six"]
        out.should_receive(:puts).with no_args
        out.should_receive(:puts).with "Weekdays"
        out.should_receive(:puts).with ["  Monday Tuesday Wednesday",
                                        "Thursday Friday   Saturday"]
        out.should_receive(:puts).with no_args
        out.should_receive(:puts).with "Colors"
        out.should_receive(:puts).with ["     Red Green        Blue",
                                        "   White Gray        Black"]
        out.should_receive(:puts).with no_args

        tables_printer.print
      end
    end
  end
end
