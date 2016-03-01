class VideoSerializer < ActiveModel::Serializer
  attributes :id, :title, :year, :imdb, :genre, :actors, :rating, :poster, :filename, 
  :folder, :size, :status, :created_at, :updated_at, :deleted, :attachments_file_name, 
  :attachments_content_type, :attachments_file_size, :attachments_updated_at, :attachments, :is3D, :thumbnail
end

  