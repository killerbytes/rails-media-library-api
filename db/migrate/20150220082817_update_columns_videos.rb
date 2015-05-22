class UpdateColumnsVideos < ActiveRecord::Migration
  def change
    change_table :videos do |t|
      t.remove :poster_file_name
      t.remove :poster_content_type
      t.remove :poster_file_size
      t.remove :poster_updated_at
      t.string :attachments
    end



  end
end
