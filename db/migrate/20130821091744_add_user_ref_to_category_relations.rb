class AddUserRefToCategoryRelations < ActiveRecord::Migration
  def change
    add_column :category_relations, :user_id, :integer
    add_index :category_relations, :user_id
  end
end
