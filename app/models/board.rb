class Board < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true
  has_many :articles, dependent: :destroy
end
