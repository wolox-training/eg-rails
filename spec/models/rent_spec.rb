require 'rails_helper'

describe Rent do
  subject(:rent) { build_stubbed(:rent) }

  it { is_expected.to be_valid }

  # Associations
  it { should belong_to(:user) }
  it { should belong_to(:book) }

  # Validations
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:book) }
  it { is_expected.to validate_presence_of(:start_at) }
  it { is_expected.to validate_presence_of(:end_at) }
end
