# frozen_string_literal: true

class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 1, maximum: 10 }
  validates :content, presence: true, length: { minimum: 1, maximum: 10000}

  belongs_to :user
  has_many :article_categories
  has_many :categories,through: :article_categories

  scope :sorted,->{order(updated_at: :desc)}

  has_rich_text :content
end
