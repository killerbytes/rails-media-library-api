class AddPosterColumnToVideo < ActiveRecord::Migration
	def self.up
   	add_attachment :videos, :poster
  	end

  	def self.down
   	remove_attachment :videos, :poster
  	end
end
