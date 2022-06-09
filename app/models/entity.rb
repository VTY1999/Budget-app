class Entity < ApplicationRecord
  belongs_to :user
  has_many :category_entities, dependent: :destroy
  has_many :categories, through: :category_entities

  validates :name, presence: true
  validates :amount, presence: true, numericality: { only_integer: true }
end
