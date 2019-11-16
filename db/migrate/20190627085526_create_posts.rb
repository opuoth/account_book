class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :memo
      t.integer :outgoing
      t.integer :incoming

      t.timestamps
    end
  end
end
