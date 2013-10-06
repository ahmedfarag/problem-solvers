class AddPrivateToSolutions < ActiveRecord::Migration
  def change
    add_column :solutions, :private, :boolean

  end
end
