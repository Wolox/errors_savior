require 'spec_helper'

describe Dummy do
  subject(:dummy) { described_class.new(name: 'name', number: 123) }

  it { is_expected.to be_valid }

  # it { is_expected.to have_many(:components) }
  # it { is_expected.to have_many(:steps) }
  # it { is_expected.to validate_presence_of(:external_id) }
  # it { is_expected.to validate_uniqueness_of(:external_id).case_insensitive }
  # it { is_expected.to have_and_belong_to_many(:tags) }
  # it { is_expected.to have_and_belong_to_many(:pots) }
  # it { is_expected.to validate_presence_of(:name) }
  # it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  # it { is_expected.to validate_presence_of(:portion) }
  # it { is_expected.to validate_length_of(:name).is_at_least(4).is_at_most(50) }
  # it { is_expected.to validate_size_of(:components).is_at_least(1) }

  # it do
  #   expect(recipe).to(validate_numericality_of(:external_id)
  #                     .only_integer
  #                     .is_greater_than(0)
  #                     .is_less_than_or_equal_to(10_000))
  # end

  # it do
  #   expect(recipe).to(validate_numericality_of(:portion)
  #                       .only_integer
  #                       .is_greater_than(0)
  #                       .is_less_than_or_equal_to(100))
  # end

  # it do
  #   expect(recipe).to(validate_numericality_of(:time)
  #                           .is_greater_than(0)
  #                           .is_less_than_or_equal_to(360)
  #                           .allow_nil)
  # end

  # it do
  #   expect(recipe).to(validate_numericality_of(:calories)
  #                           .is_greater_than(0)
  #                           .is_less_than_or_equal_to(2_000)
  #                           .allow_nil)
  # end
end
