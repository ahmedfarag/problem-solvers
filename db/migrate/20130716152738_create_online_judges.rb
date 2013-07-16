class CreateOnlineJudges < ActiveRecord::Migration
  def change
    create_table :online_judges do |t|
      t.string :name
      t.string :link

      t.timestamps
    end
  end
end
