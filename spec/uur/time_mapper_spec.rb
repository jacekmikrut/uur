require "spec_helper"

describe Uur::TimeMapper do

  subject { Uur::TimeMapper.new(now) }
  let(:now) { stub(:now) }

  it { should respond_to :since }
  it { should respond_to :to    }
end
