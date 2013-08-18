class AddTitleColumnToHints < ActiveRecord::Migration
  def change
    add_column :hints, :title, :string

  end
end
