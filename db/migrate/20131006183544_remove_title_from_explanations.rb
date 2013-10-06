class RemoveTitleFromExplanations < ActiveRecord::Migration
  def up
    remove_column :explanations, :title
      end

  def down
    add_column :explanations, :title, :string
  end
end
