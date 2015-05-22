class AddColumnToVideo < ActiveRecord::Migration
  def change
    change_table :videos do |t|
      t.boolean :is3D
    end


  end
end
