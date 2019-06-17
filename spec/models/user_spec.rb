require 'rails_helper'

describe User do
  subject(:user) { build_stubbed(:user) }

  it { is_expected.to be_valid }

  # Associations
  it { should have_many(:rents) }

  # Validations
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_inclusion_of(:locale).in_array(I18n.available_locales.map(&:to_s)) }
end
