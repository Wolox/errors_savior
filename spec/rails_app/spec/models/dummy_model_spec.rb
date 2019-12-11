require 'spec_helper'

describe Dummy do
  subject(:dummy) { described_class.new(name: 'name', number: 123) }

  it { is_expected.to be_valid }
end
