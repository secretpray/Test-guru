# frozen_string_literal: true

class Badge < ApplicationRecord

  has_many :users, through: :users_badge
  has_many :users_badge, dependent: :destroy

  validates :rule, numericality: { only_integer: true }
  validates :title, presence: true
  validates :image, presence: true

  RULES = [
          I18n.t('.rules_array.first_attemp'),
          I18n.t('.rules_array.all_category_two'),
          I18n.t('.rules_array.all_category_one'),
          I18n.t('.rules_array.all_level_medium'),
          I18n.t('.rules_array.all_tests')
        ]

  def self.images
    images_path = 'app/assets/images/'
    badges = Dir.glob("#{images_path}badges/*")
    badges.map { |badge_path| badge_path.gsub(images_path, '') }
  end

end
