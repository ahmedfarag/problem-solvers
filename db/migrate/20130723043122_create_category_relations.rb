class CreateCategoryRelations < ActiveRecord::Migration
  def change
    create_table :category_relations do |t|
      t.references :category
      t.references :categorizable, polymorphic: true

      t.timestamps
    end
    add_index :category_relations, :category_id
    add_index :category_relations, :categorizable_id
  end
end
