class Video < ActiveRecord::Base
  has_attached_file :attachments, 
  :path => "public/posters/:id/:style/:basename.:extension", 
  :url => "posters/:id/:style/:basename.:extension",  

  :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
  :default_url => "posters/placeholder.jpg"
  # validates_attachment_content_type :attachments, :content_type => /\Aimage\/.*\Z/
  validates_attachment :attachments,
  :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

  

end
