# frozen_string_literal: true
class Article < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { minimum: 1, maximum:10 }
  validates :description, presence: true, length: { minimum: 1, maximum: 100 }
end
