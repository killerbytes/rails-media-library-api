class RemoveDeleteColumn < ActiveRecord::Migration
  def change
    change_table :videos do |t|
      t.remove :delete
      t.boolean :deleted
    end



  end
end
