class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.integer :year
      t.string :imdb
      t.text :genre
      t.text :actors
      t.string :rating
      t.string :poster
      t.string :filename
      t.string :folder
      t.integer :size
      t.boolean :status
      t.boolean :delete

      t.timestamps null: false
    end
  end
end
