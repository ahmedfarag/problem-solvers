class CreateUnlocks < ActiveRecord::Migration
  def change
    create_table :unlocks do |t|
      t.references :user
      t.references :unlockable, polymorphic: true

      t.timestamps
    end
    add_index :unlocks, :user_id
    add_index :unlocks, :unlockable_id
  end
end
