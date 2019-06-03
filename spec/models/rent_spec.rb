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
      it 'not have errors' do
        valid_rent = build_stubbed(:rent)
        valid_rent.send(:end_at_after_start_at)

        expect(valid_rent.errors.empty?).to be(true)
      end
    end

    context 'with the end_at less than start_at date' do
      it 'be include errors' do
        valid_rent = build_stubbed(:rent, start_at: 1.week.after, end_at: 1.day.after)
        valid_rent.send(:end_at_after_start_at)

        expect(valid_rent.errors.include?(:end_at)).to be(true)
        expect(valid_rent.errors.messages[:end_at]).to eq ['must be after the start date']
      end
    end
  end

  describe '#dates_are_not_passed' do
    context 'with correct dates' do
      it 'not have errors' do
        valid_rent = build_stubbed(:rent)
        valid_rent.send(:dates_are_not_passed)

        expect(valid_rent.errors.empty?).to be(true)
      end
    end

    context 'with the start_at less than now' do
      it 'be include errors' do
        valid_rent = build_stubbed(:rent, start_at: 1.week.ago, end_at: 1.week.after)
        valid_rent.send(:dates_are_not_passed)

        expect(valid_rent.errors.include?(:start_at)).to be(true)
        expect(valid_rent.errors.messages[:start_at]).to eq ['must be after today']
      end
    end

    context 'with the end_at less than now' do
      it 'be include errors' do
        valid_rent = build_stubbed(:rent, start_at: Time.zone.now, end_at: 1.day.ago)
        valid_rent.send(:dates_are_not_passed)

        expect(valid_rent.errors.include?(:end_at)).to be(true)
        expect(valid_rent.errors.messages[:end_at]).to eq ['must be after today']
      end
    end
  end

  describe '#available_book' do
    context 'is not already rented' do
      it 'not have errors' do
        subject.send(:available_book)

        expect(subject.errors.empty?).to be(true)
      end
    end

    context 'is already rented' do
      it 'be include errors' do
        Rent.any_instance.stub(:available?).and_return(false)
        subject.send(:available_book)

        expect(subject.errors.include?(:base)).to be(true)
        expect(subject.errors.messages[:base]).to eq ['is already rented']
      end
    end
  end

  describe '#available?' do
    context 'is not already rented' do
      it 'not have errors' do
        expect(subject.available?).to be(true)
      end
    end

    context 'is already rented' do
      context 'start_at in the range' do
        it 'be include errors' do
          old_rent = create(:rent_with_user_and_book)

          new_rent = build_stubbed(
            :rent_with_user_and_book,
            book: old_rent.book,
            end_at: 3.weeks.after
          )

          expect(new_rent.available?).to be(false)
        end
      end

      context 'end_at in the range' do
        it 'be include errors' do
          old_rent = create(
            :rent_with_user_and_book,
            start_at: 2.days.after,
            end_at: 2.weeks.after
          )

          new_rent = build_stubbed(
            :rent_with_user_and_book,
            book: old_rent.book,
            start_at: Time.zone.now,
            end_at: 1.week.after
          )

          expect(new_rent.available?).to be(false)
        end
      end
    end
  end
end
