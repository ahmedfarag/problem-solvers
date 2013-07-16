class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :stars
      t.text :content
      t.references :user
      t.references :reviewable, polymorphic: true

      t.timestamps
    end
    add_index :reviews, :user_id
    add_index :reviews, :reviewable_id
  end
end
