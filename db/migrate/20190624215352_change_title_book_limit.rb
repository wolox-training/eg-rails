class ChangeTitleBookLimit < ActiveRecord::Migration[5.2]
  def up
    change_column :books, :title, :string, limit: 25
  end

  def down
    change_column :books, :title, :string, limit: 255
  end
end
