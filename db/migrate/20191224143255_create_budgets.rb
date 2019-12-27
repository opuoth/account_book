class CreateBudgets < ActiveRecord::Migration[5.0]
  def change
    create_table :budgets do |t|
      t.integer :budget_type
      t.integer :price
      t.date :date
      t.string :memo
      t.integer :category_id

      t.timestamps
    end
  end
end
