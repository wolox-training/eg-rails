class TruncateBookTitles < ActiveRecord::Migration[5.2]
  def change
    Book.find_each do |book|
      if book.title.size > 25
        truncate_title = book.title.truncate(25)
        book.update_attribute(:title, truncate_title)
      end
    end
  end
end
