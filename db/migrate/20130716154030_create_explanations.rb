class CreateExplanations < ActiveRecord::Migration
  def change
    create_table :explanations do |t|
      t.text :content
      t.references :problem
      t.references :user

      t.timestamps
    end
    add_index :explanations, :problem_id
    add_index :explanations, :user_id
  end
end
