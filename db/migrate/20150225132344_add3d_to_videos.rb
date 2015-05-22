class Add3dToVideos < ActiveRecord::Migration
	def self.up
   	add_attachment :videos, :is3D
  	end
end
