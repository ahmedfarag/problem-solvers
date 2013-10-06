class RemoveTitleFromSolutions < ActiveRecord::Migration
  def up
    remove_column :solutions, :title
      end

  def down
    add_column :solutions, :title, :string
  end
end
