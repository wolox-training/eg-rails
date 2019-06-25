class ChangeColumn < ActiveRecord::Migration[5.2]
  def up
    Book.all.each do |book|
      if book.title.size > 25
        truncate_title = book.title.truncate(25)
        book.update_attribute(:title, truncate_title)
      end
    end

    change_column :books, :title, :string, limit: 25
  end

  def down
    change_column :books, :title, :string, limit: 255
  end
end
