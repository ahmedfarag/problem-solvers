class AddTitleColumnToExplanations < ActiveRecord::Migration
  def change
    add_column :explanations, :title, :string

  end
end
