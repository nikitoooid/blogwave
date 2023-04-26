class Article < ApplicationRecord
  belongs_to :user

  validates :title, presence: true

  has_one_attached :cover_image
  has_rich_text :content
end
