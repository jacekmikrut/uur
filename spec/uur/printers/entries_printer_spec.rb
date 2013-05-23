require "spec_helper"

describe Uur::Printers::EntriesPrinter do

  subject(:entries_printer) { described_class.new(duration_formatter, out) }
  let(:duration_formatter) { stub(:duration_formatter) }
  let(:out               ) { stub(:out) }
  before { duration_formatter.stub(:format) { |duration| "formatted:#{duration}" } }

  describe "#print" do

    context "when there are entries to print" do

      let(:entry_1) do
        Uur::Entry.new(
          starts_at: Time.new(2013, 5, 22, 10, 30),
          ends_at:   Time.new(2013, 5, 22, 11, 15),
          project_name: "Project A",
          description:  "Completed task A1"
        )
      end

      let(:entry_2) do
        Uur::Entry.new(
          starts_at: Time.new(2013, 5, 22, 12, 10),
          ends_at:   Time.new(2013, 5, 22, 12, 25),
          project_name: "Project A",
          description:  "Completed task A2"
        )
      end

      let(:entry_3) do
        Uur::Entry.new(
          starts_at: Time.new(2013, 5, 22, 12, 25),
          ends_at:   Time.new(2013, 5, 22, 12, 50),
          project_name: "Project B",
          description:  "Completed task B1"
        )
      end

      let(:entry_4) do
        Uur::Entry.new(
          starts_at: Time.new(2013, 5, 22, 13, 0),
          ends_at:   Time.new(2013, 5, 22, 15, 0),
          project_name: "Project A",
          description:  "Completed task A3"
        )
      end

      let(:entry_5) do
        Uur::Entry.new(
          starts_at: Time.new(2013, 5, 24, 11,  0),
          ends_at:   Time.new(2013, 5, 24, 11, 30),
          project_name: "Project A",
          description:  "Completed task A4"
        )
      end

      let(:entries) do
        Uur::Entries.new([entry_1, entry_2, entry_3, entry_4, entry_5])
      end

      it "should delegate printing to a TablesPrinter object" do
        Uur::TablePrinting::TablesPrinter.should_receive(:new).with(
          [ Uur::TablePrinting::Table.new("Wed, 22 May 2013", [
                                          ["10:30 - 11:15", "formatted:2700",  "Project A", "Completed task A1"],
                                          ["12:10 - 12:25", "formatted:900",   "Project A", "Completed task A2"],
                                          ["12:25 - 12:50", "formatted:1500",  "Project B", "Completed task B1"],
                                          ["13:00 - 15:00", "formatted:7200",  "Project A", "Completed task A3"],
                                          ["       Total:", "formatted:12300", "",          "" ]
                                         ]),
            Uur::TablePrinting::Table.new("Fri, 24 May 2013", [
                                          ["11:00 - 11:30", "formatted:1800",  "Project A", "Completed task A4"],
                                          ["       Total:", "formatted:1800",  "",          "" ]
                                         ])
          ],
          [:left, :right, :left, :left],
          out
        ).and_return(tables_printer = stub(:tables_printer))
        tables_printer.should_receive(:print).with(no_args)

        entries_printer.print(entries)
      end
    end

    context "when there are no entries to print" do
      let(:entries) do
        Uur::Entries.new([])
      end

      it "should delegate printing to a TablesPrinter object" do
        Uur::TablePrinting::TablesPrinter.should_receive(:new).with(
          [],
          [:left, :right, :left, :left],
          out
        ).and_return(tables_printer = stub(:tables_printer))
        tables_printer.should_receive(:print).with(no_args)

        entries_printer.print(entries)
      end
    end
  end
end
