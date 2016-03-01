class Video < ActiveRecord::Base
	# attr_accessor :photo
	# attr_accessor :thumbnail

	def thumbnail
		self.attachments(:medium)
	end

  has_attached_file :attachments, 
  	:path => "posters/:id/:style/:filename",
  	:styles => { :medium => "300x300>", :thumb => "100x100>" }, 
  	:default_url => "posters/placeholder.jpg"
	  validates_attachment :attachments,
  	:content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

	self.per_page = 10


end
