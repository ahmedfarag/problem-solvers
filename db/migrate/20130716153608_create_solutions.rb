class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.text :code
      t.references :language
      t.references :problem
      t.boolean :accepted
      t.references :user

      t.timestamps
    end
    add_index :solutions, :language_id
    add_index :solutions, :problem_id
    add_index :solutions, :user_id
  end
end
