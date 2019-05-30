require 'rails_helper'

describe Book do
  subject(:book) { create(:book) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:author) }
  it { is_expected.to validate_presence_of(:year) }
  it { is_expected.to validate_presence_of(:editor) }
  it { is_expected.to validate_presence_of(:gender) }
  it { is_expected.to validate_presence_of(:image) }
end