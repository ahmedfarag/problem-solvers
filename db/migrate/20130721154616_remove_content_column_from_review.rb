class RemoveContentColumnFromReview < ActiveRecord::Migration
  def up
    remove_column :reviews, :content
      end

  def down
    add_column :reviews, :content, :text
  end
end
