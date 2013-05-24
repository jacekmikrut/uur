require "spec_helper"

describe Uur::Printers::SummaryPrinter do

  subject(:summary_printer) { described_class.new(duration_formatter, out) }
  let(:duration_formatter) { stub(:duration_formatter) }
  let(:out               ) { stub(:out) }
  before { duration_formatter.stub(:format) { |duration| "formatted:#{duration}" } }

  describe "#print" do

    context "when there are entries for the summary" do

      let(:entry_1) do
        Uur::Entry.new(
          starts_at: Time.new(2012, 12, 7, 14, 30),
          ends_at:   Time.new(2012, 12, 7, 14, 40),
          project_name: "Project A",
          description:  "Completed task A1"
        )
      end

      let(:entry_2) do
        Uur::Entry.new(
          starts_at: Time.new(2013, 4, 29,  9, 30),
          ends_at:   Time.new(2013, 4, 29, 14,  0),
          project_name: "Project A",
          description:  "Completed task A1"
        )
      end

      let(:entry_3) do
        Uur::Entry.new(
          starts_at: Time.new(2013, 4, 29, 15,  0),
          ends_at:   Time.new(2013, 4, 29, 17, 30),
          project_name: "Project A",
          description:  "Completed task A2"
        )
      end

      let(:entry_4) do
        Uur::Entry.new(
          starts_at: Time.new(2013, 5, 14, 8, 20),
          ends_at:   Time.new(2013, 5, 14, 8, 50),
          project_name: "Project B",
          description:  "Completed task B1"
        )
      end

      let(:entry_5) do
        Uur::Entry.new(
          starts_at: Time.new(2013, 5, 22, 12, 25),
          ends_at:   Time.new(2013, 5, 22, 12, 50),
          project_name: "Project B",
          description:  "Completed task B2"
        )
      end

      let(:entry_6) do
        Uur::Entry.new(
          starts_at: Time.new(2013, 5, 22, 13, 0),
          ends_at:   Time.new(2013, 5, 22, 15, 0),
          project_name: "Project A",
          description:  "Completed task A3"
        )
      end

      let(:entry_7) do
        Uur::Entry.new(
          starts_at: Time.new(2013, 5, 22, 15,  0),
          ends_at:   Time.new(2013, 5, 22, 17, 30),
          project_name: "Project C",
          description:  "Completed task C1"
        )
      end

      let(:entry_8) do
        Uur::Entry.new(
          starts_at: Time.new(2013, 5, 22, 17, 30),
          ends_at:   Time.new(2013, 5, 22, 17, 45),
          project_name: "Project B",
          description:  "Completed task B3"
        )
      end

      let(:entry_9) do
        Uur::Entry.new(
          starts_at: Time.new(2013, 5, 23, 8,  0),
          ends_at:   Time.new(2013, 5, 23, 9, 45),
          project_name: "Project B",
          description:  "Completed task B4"
        )
      end

      let(:entries) do
        Uur::Entries.new([entry_1, entry_2, entry_3, entry_4, entry_5, entry_6, entry_7, entry_8, entry_9])
      end

      context "with daily interval" do

        it "should delegate printing to a TablesPrinter object" do
          Uur::TablePrinting::TablesPrinter.should_receive(:new).with(
            [ Uur::TablePrinting::Table.new("Fri, 07 December 2012", [
                                            ["Project A", "formatted:600"],
                                            ["Total:", "formatted:600"]
                                          ]),
              Uur::TablePrinting::Table.new("Mon, 29 April 2013", [
                                            ["Project A", "formatted:25200"],
                                            ["Total:", "formatted:25200"]
                                          ]),
              Uur::TablePrinting::Table.new("Tue, 14 May 2013", [
                                            ["Project B", "formatted:1800" ],
                                            ["Total:", "formatted:1800" ]
                                          ]),
              Uur::TablePrinting::Table.new("Wed, 22 May 2013", [
                                            ["Project A", "formatted:7200" ],
                                            ["Project B", "formatted:2400" ],
                                            ["Project C", "formatted:9000" ],
                                            ["Total:", "formatted:18600"]
                                          ]),
              Uur::TablePrinting::Table.new("Thu, 23 May 2013", [
                                            ["Project B", "formatted:6300" ],
                                            ["Total:", "formatted:6300" ]
                                          ])
            ],
            [:left, :right],
            out
          ).and_return(tables_printer = stub(:tables_printer))
          tables_printer.should_receive(:print).with(no_args)

          summary_printer.print(entries, "daily")
        end
      end

      context "with weekly interval" do

        it "should delegate printing to a TablesPrinter object" do
          Uur::TablePrinting::TablesPrinter.should_receive(:new).with(
            [ Uur::TablePrinting::Table.new("03 December 2012 - 09 December 2012", [
                                            ["Project A", "formatted:600"],
                                            ["Total:", "formatted:600"]
                                          ]),
              Uur::TablePrinting::Table.new("29 April 2013 - 05 May 2013", [
                                            ["Project A", "formatted:25200"],
                                            ["Total:", "formatted:25200"]
                                          ]),
              Uur::TablePrinting::Table.new("13 May 2013 - 19 May 2013", [
                                            ["Project B", "formatted:1800" ],
                                            ["Total:", "formatted:1800"]
                                          ]),
              Uur::TablePrinting::Table.new("20 May 2013 - 26 May 2013", [
                                            ["Project A", "formatted:7200" ],
                                            ["Project B", "formatted:8700" ],
                                            ["Project C", "formatted:9000" ],
                                            ["Total:", "formatted:24900"]
                                          ])
            ],
            [:left, :right],
            out
          ).and_return(tables_printer = stub(:tables_printer))
          tables_printer.should_receive(:print).with(no_args)

          summary_printer.print(entries, "weekly")
        end
      end

      context "with monthly interval" do

        it "should delegate printing to a TablesPrinter object" do
          Uur::TablePrinting::TablesPrinter.should_receive(:new).with(
            [ Uur::TablePrinting::Table.new("December 2012", [
                                            ["Project A", "formatted:600"],
                                            ["Total:", "formatted:600"]
                                          ]),
              Uur::TablePrinting::Table.new("April 2013", [
                                            ["Project A", "formatted:25200"],
                                            ["Total:", "formatted:25200"]
                                          ]),
              Uur::TablePrinting::Table.new("May 2013", [
                                            ["Project A", "formatted:7200" ],
                                            ["Project B", "formatted:10500" ],
                                            ["Project C", "formatted:9000" ],
                                            ["Total:", "formatted:26700"]
                                          ])
            ],
            [:left, :right],
            out
          ).and_return(tables_printer = stub(:tables_printer))
          tables_printer.should_receive(:print).with(no_args)

          summary_printer.print(entries, "monthly")
        end
      end

      context "with yearly interval" do

        it "should delegate printing to a TablesPrinter object" do
          Uur::TablePrinting::TablesPrinter.should_receive(:new).with(
            [ Uur::TablePrinting::Table.new("Year 2012", [
                                            ["Project A", "formatted:600" ],
                                            ["Total:", "formatted:600"]
                                          ]),
              Uur::TablePrinting::Table.new("Year 2013", [
                                            ["Project A", "formatted:32400" ],
                                            ["Project B", "formatted:10500" ],
                                            ["Project C", "formatted:9000" ],
                                            ["Total:", "formatted:51900"]
                                          ])
            ],
            [:left, :right],
            out
          ).and_return(tables_printer = stub(:tables_printer))
          tables_printer.should_receive(:print).with(no_args)

          summary_printer.print(entries, "yearly")
        end
      end

      context "for all entries" do

        it "should delegate printing to a TablesPrinter object" do
          Uur::TablePrinting::TablesPrinter.should_receive(:new).with(
            [ Uur::TablePrinting::Table.new("All time summary", [
                                            ["Project A", "formatted:33000" ],
                                            ["Project B", "formatted:10500" ],
                                            ["Project C", "formatted:9000" ],
                                            ["Total:", "formatted:52500"]
                                          ])
            ],
            [:left, :right],
            out
          ).and_return(tables_printer = stub(:tables_printer))
          tables_printer.should_receive(:print).with(no_args)

          summary_printer.print(entries)
        end
      end
    end

    context "when there are no entries for the summary" do
      let(:entries) do
        Uur::Entries.new([])
      end

      it "should delegate printing to a TablesPrinter object" do
        Uur::TablePrinting::TablesPrinter.should_receive(:new).with(
          [],
          [:left, :right],
          out
        ).and_return(tables_printer = stub(:tables_printer))
        tables_printer.should_receive(:print).with(no_args)

        summary_printer.print(entries, "daily")
      end
    end
  end
end
