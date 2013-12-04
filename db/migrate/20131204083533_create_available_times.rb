class CreateAvailableTimes < ActiveRecord::Migration
  def change
    create_table :available_times do |t|
      t.references :user
      t.timestamp :time

      t.timestamps
    end
    add_index :available_times, :user_id
  end
end
