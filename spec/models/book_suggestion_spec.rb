require 'rails_helper'

RSpec.describe BookSuggestion, type: :model do
  subject(:book) { build_stubbed(:book_suggestion) }

  it { is_expected.to be_valid }

  # Associations
  it { should belong_to(:user).optional }

  # Validations
  it { is_expected.to validate_presence_of(:author) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:link) }
  it { is_expected.to validate_presence_of(:editor) }
  it { is_expected.to validate_presence_of(:year) }
end
