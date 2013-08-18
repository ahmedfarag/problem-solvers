class AddTitleColumnToSolutions < ActiveRecord::Migration
  def change
    add_column :solutions, :title, :string

  end
end
