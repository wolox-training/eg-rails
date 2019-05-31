require 'rails_helper'

describe Rent do
  subject(:rent) { build_stubbed(:rent_with_user_and_book) }

  it { is_expected.to be_valid }

  # Associations
  it { should belong_to(:user) }
  it { should belong_to(:book) }

  # Validations
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:book) }
  it { is_expected.to validate_presence_of(:start_at) }
  it { is_expected.to validate_presence_of(:end_at) }

  describe '#end_at_after_start_at' do
    context 'with correct dates' do
      it 'should not have errors' do
        valid_rent = build_stubbed(:rent)
        valid_rent.send(:end_at_after_start_at)

        expect(valid_rent.errors.empty?).to be(true)
      end
    end

    context 'with the end_at less than start_at date' do
      it 'should be include errors' do
        valid_rent = build_stubbed(:rent, start_at: 1.week.ago, end_at: 2.weeks.ago)
        valid_rent.send(:end_at_after_start_at)

        expect(valid_rent.errors.include?(:end_at)).to be(true)
      end
    end
  end
end
