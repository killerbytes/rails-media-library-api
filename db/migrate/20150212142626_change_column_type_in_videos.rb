class ChangeColumnTypeInVideos < ActiveRecord::Migration
  def change
  	  	change_column :videos, :size, :string
  end
end
