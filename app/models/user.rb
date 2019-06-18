# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :rents, dependent: :destroy
  has_many :book_suggestions, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :locale, inclusion:
    { in: I18n.available_locales.map(&:to_s) }
end
