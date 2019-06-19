require 'rails_helper'

describe BookSuggestionPolicy do
  subject { described_class.new(user, book_suggestion) }

  context '#create?' do
    let(:book_suggestion) { build_stubbed(:book_suggestion, :with_user) }

    context 'different user of book_suggestion params' do
      let(:user) { build_stubbed(:user) }

      it { is_expected.to_not permit_action(:create) }
    end

    context 'same user of rent params' do
      let(:user) { book_suggestion.user }

      it { is_expected.to permit_action(:create) }
    end
  end
end
