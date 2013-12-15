class CreatePublicLinks < ActiveRecord::Migration
  def change
    create_table :public_links do |t|
      t.references :unlockable, polymorphic: true
      t.string :hashed_id

      t.timestamps
    end
    add_index :public_links, :unlockable_id
  end
end
