class CreateHints < ActiveRecord::Migration
  def change
    create_table :hints do |t|
      t.text :content
      t.integer :clarity
      t.references :problem
      t.references :user

      t.timestamps
    end
    add_index :hints, :problem_id
    add_index :hints, :user_id
  end
end
