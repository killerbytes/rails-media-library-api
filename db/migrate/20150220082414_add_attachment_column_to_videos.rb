class AddAttachmentColumnToVideos < ActiveRecord::Migration
	def self.up
   	add_attachment :videos, :attachments
  	end

  	def self.down
   	remove_attachment :videos, :attachments
  	end
end
