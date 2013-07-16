class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :name
      t.string :link
      t.references :online_judge

      t.timestamps
    end
    add_index :problems, :online_judge_id
  end
end
