require 'rails_helper'

describe RentPolicy do
  subject { described_class.new(user, rent) }

  context '#index?' do
    let(:rent) { [build_stubbed(:rent_with_user_and_book)] }

    context 'different user of the rents' do
      let(:user) { build_stubbed(:user) }

      it { is_expected.to_not permit_action(:index) }
    end

    context 'same user of the rents' do
      let(:user) { rent[0].user }

      it { is_expected.to permit_action(:index) }
    end
  end

  context '#create?' do
    let(:rent) { build_stubbed(:rent_with_user_and_book) }

    context 'different user of rent params' do
      let(:user) { build_stubbed(:user) }

      it { is_expected.to_not permit_action(:create) }
    end

    context 'same user of rent params' do
      let(:user) { rent.user }

      it { is_expected.to permit_action(:create) }
    end
  end
end
