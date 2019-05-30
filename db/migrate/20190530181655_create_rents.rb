class CreateRents < ActiveRecord::Migration[5.2]
  def change
    create_table :rents do |t|
      t.references :user, foreign_key: true, null: false, index: true
      t.references :book, foreign_key: true, null: false, index: true
      t.datetime :start_at, null: false, index: true
      t.datetime :end_at, null: false, index: true

      t.timestamps
    end
  end
end
