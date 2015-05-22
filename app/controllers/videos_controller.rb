class VideosController < ApplicationController
	config.relative_url_root = ""
 	respond_to :json, :html
 	
 	def index
		if params[:status].nil?
			@videos = Video.select(:id,:title, :year, :imdb, :genre, :actors, :rating, :filename, :folder, :size, :attachments, :attachments_file_name, :is3D, :created_at, :poster).where({:status => true, :deleted => false, :deleted => nil})
		elsif
			@videos = Video.where(status: false, status: nil, deleted: false, deleted: nil)
		end
 		if @videos.blank?
	 		@videos = []
	 	elsif 	 		
	 		@videos.order(:title)
			@videos = @videos.order(:title)
		end
		respond_with(@videos)

	end

	def show
		@video = Video.where(id: params[:id]).first
		respond_with(@video)
	end

	def update
		video = Video.where(id: params[:id])	
		respond_with video.update(video_params)	
	end

	def destroy
		video = Video.where(id: params[:id])
		respond_with video.update({deleted: true})
	end


	def upload
		uploaded_file = params[:file]
		@uploaded = Array.new
		if(uploaded_file)
			uploaded_file.read.each_line do |line|
				@array = line.split("/")
				@filename = @array.last.strip
				@folder = line.split("./").last.strip
				@size = @array.first.gsub(/\t./, "")
				@exist = Video.find_by_filename(@filename)
				# p @array.last
				if(@exist != nil)
					@exist.folder = @folder
					@exist.size = @size
					@exist.save()
				else
					@video = Video.create(
						:filename => @filename, 
						:folder => @folder, 
						:size => @size )
				end
			end
		end

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @videos }
		end

	end

	private
		def video_params
			params.require(:video).permit(:attachments,:title, :year, :imdb, :genre, :actors, :rating, :poster, :filename, :folder, :size, :status, :deleted, :is3D)
		end


end
