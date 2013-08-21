class AddIndexToProblemsLink < ActiveRecord::Migration
  def change
  	add_index :problems, :link, unique: true
  end
end
