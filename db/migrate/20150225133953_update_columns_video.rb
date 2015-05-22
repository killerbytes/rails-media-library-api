class UpdateColumnsVideo < ActiveRecord::Migration
  def change
    change_table :videos do |t|
      t.remove :is3D_file_name
      t.remove :is3D_content_type
      t.remove :is3D_file_size
      t.remove :is3D_updated_at
    end
    
   end
end
