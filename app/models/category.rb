class Category < ApplicationRecord
  has_many :budgets
  validates :name, presence: true
  validates :budget_type, presence: true
  # validates :name, uniqueness: true
end
