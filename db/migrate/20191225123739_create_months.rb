class CreateMonths < ActiveRecord::Migration[5.0]
  def change
    create_table :months do |t|
      t.integer :year
      t.integer :month
      t.integer :outgo, default: 0
      t.integer :income, default: 0

      t.timestamps
    end
  end
end
