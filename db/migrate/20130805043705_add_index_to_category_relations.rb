class AddIndexToCategoryRelations < ActiveRecord::Migration
  def change
  	add_index :category_relations, [:category_id, :categorizable_id, :categorizable_type], unique: true, name: "category_categorizable_index"
  end
end
