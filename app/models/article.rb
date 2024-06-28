# frozen_string_literal: true

class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 1, maximum: 100 }
  validates :content, presence: true, length: { minimum: 1, maximum: 10000000}

  belongs_to :user
  has_many :article_categories
  has_many :categories,through: :article_categories

  scope :sorted,->{order(updated_at: :desc)}
  scope :search_article_title, ->(title){
    sql='title LIKE ?'
    where(sql,"%#{title}%")
  }
  has_rich_text :content
end
