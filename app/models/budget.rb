class Budget < ApplicationRecord
  belongs_to :category
  [:date, :price, :budget_type, :category_id].each do |v|
    validates v, presence: true
  end
end
