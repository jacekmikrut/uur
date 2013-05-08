require "spec_helper"

describe "Each Time instance after including", Uur::Mixins::TimeMixin do

  context "for 2012-02-29 20:10:05" do
    subject(:time) { Time.new(2012, 2, 29, 20, 10, 5) }

    its(:beginning_of_day           ) { should eq Time.new(2012,  2, 29,  0,  0,  0) }
    its(      :end_of_day           ) { should eq Time.new(2012,  2, 29, 23, 59, 59) }
    its(:beginning_of_previous_day  ) { should eq Time.new(2012,  2, 28,  0,  0,  0) }
    its(      :end_of_previous_day  ) { should eq Time.new(2012,  2, 28, 23, 59, 59) }

    its(:beginning_of_week          ) { should eq Time.new(2012,  2, 27,  0,  0,  0) }
    its(      :end_of_week          ) { should eq Time.new(2012,  3,  4, 23, 59, 59) }
    its(:beginning_of_previous_week ) { should eq Time.new(2012,  2, 20,  0,  0,  0) }
    its(      :end_of_previous_week ) { should eq Time.new(2012,  2, 26, 23, 59, 59) }

    its(:beginning_of_month         ) { should eq Time.new(2012,  2,  1,  0,  0,  0) }
    its(      :end_of_month         ) { should eq Time.new(2012,  2, 29, 23, 59, 59) }
    its(:beginning_of_previous_month) { should eq Time.new(2012,  1,  1,  0,  0,  0) }
    its(      :end_of_previous_month) { should eq Time.new(2012,  1, 31, 23, 59, 59) }

    its(:beginning_of_year          ) { should eq Time.new(2012,  1,  1,  0,  0,  0) }
    its(      :end_of_year          ) { should eq Time.new(2012, 12, 31, 23, 59, 59) }
    its(:beginning_of_previous_year ) { should eq Time.new(2011,  1,  1,  0,  0,  0) }
    its(      :end_of_previous_year ) { should eq Time.new(2011, 12, 31, 23, 59, 59) }
  end

  context "for 2013-01-01 20:10:05" do
    subject(:time) { Time.new(2013, 1, 1, 20, 10, 5) }

    its(:beginning_of_day           ) { should eq Time.new(2013,  1,  1,  0,  0,  0) }
    its(      :end_of_day           ) { should eq Time.new(2013,  1,  1, 23, 59, 59) }
    its(:beginning_of_previous_day  ) { should eq Time.new(2012, 12, 31,  0,  0,  0) }
    its(      :end_of_previous_day  ) { should eq Time.new(2012, 12, 31, 23, 59, 59) }

    its(:beginning_of_week          ) { should eq Time.new(2012, 12, 31,  0,  0,  0) }
    its(      :end_of_week          ) { should eq Time.new(2013,  1,  6, 23, 59, 59) }
    its(:beginning_of_previous_week ) { should eq Time.new(2012, 12, 24,  0,  0,  0) }
    its(      :end_of_previous_week ) { should eq Time.new(2012, 12, 30, 23, 59, 59) }

    its(:beginning_of_month         ) { should eq Time.new(2013,  1,  1,  0,  0,  0) }
    its(      :end_of_month         ) { should eq Time.new(2013,  1, 31, 23, 59, 59) }
    its(:beginning_of_previous_month) { should eq Time.new(2012, 12,  1,  0,  0,  0) }
    its(      :end_of_previous_month) { should eq Time.new(2012, 12, 31, 23, 59, 59) }

    its(:beginning_of_year          ) { should eq Time.new(2013,  1,  1,  0,  0,  0) }
    its(      :end_of_year          ) { should eq Time.new(2013, 12, 31, 23, 59, 59) }
    its(:beginning_of_previous_year ) { should eq Time.new(2012,  1,  1,  0,  0,  0) }
    its(      :end_of_previous_year ) { should eq Time.new(2012, 12, 31, 23, 59, 59) }
  end
end
