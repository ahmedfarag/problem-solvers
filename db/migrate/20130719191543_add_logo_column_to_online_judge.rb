class AddLogoColumnToOnlineJudge < ActiveRecord::Migration
  def change
    add_column :online_judges, :logo, :string

  end
end
