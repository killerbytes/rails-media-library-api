class VideosController < ApplicationController
	before_action :set_video, only: [:show, :update, :destroy]
	config.relative_url_root = ""
 	respond_to :json, :html

	def default_serializer_options
		{root: false}
	end

 	
 	def index
 		# status = params[:status].nil? || params[:status]
 		# page = !params[:page].nil? #|| params[:page]

		# if params[:status] == "false"
		# 	@videos = Video.where(:status => false)
		# elsif
		# 	@videos = Video.select(:id,:title, :year, :imdb, :genre, :actors, :rating, :filename, :folder, :size, :attachments_file_name, :is3D, :created_at, :poster)
		# 	.where({:status => true})
		# 	.order(:title)
		# # 	# .limit(5)
		# end
		# if params[:deleted].nil?
	 # 		deleted = params[:deleted] == 'true' ? true : false
		# @videos = Video.select(:id,:title, :year, :imdb, :genre, :actors, :rating, :filename, :folder, :size, :attachments_file_name, :is3D, :created_at, :poster)
		# p "============="
		# p params[:status]
		# p "============="
		@videos = Video.all

		if params[:page].present?
			@videos = @videos.paginate(:page => params[:page])
		end

		if params[:deleted].present?
			deleted = ActiveRecord::Type::Boolean.new.type_cast_from_user(params[:deleted])
			@videos = @videos.where(:deleted => deleted)
		# else
		# 	@videos = @videos.where(:deleted => false)			
		end

		if params[:status].present?
			status = ActiveRecord::Type::Boolean.new.type_cast_from_user(params[:status])
			@videos = @videos.where(:status => status)
		else
			@videos = @videos.where(:status => true)			
		end

		@videos = @videos.order(:title)

		# if page == true
		# 	@videos = Video.paginate(:page => params[:page])
		# 		.where(:status => status, :deleted => false)			
		# 		.order(:title)
		# else
		# 	@videos = Video
		# 		.select(:id,:title, :year, :imdb, :genre, :actors, :rating, :filename, :folder, :size, :attachments_file_name, :is3D, :created_at)
		# 		.where(:status => status)			
		# 		.order(:title)

		# end

		respond_with(@videos)
	end

	def deleted
		@videos = Video.where(:deleted => true)			
		respond_with(@videos)
	end


	def show
		# @video = Video.find( params[:id] )
		# @video.poster = @video.attachments_file_name ? @video.attachments_file_name : @video.attachments
		respond_with(@video)
	end

	def update
		# video = Video.find( params[:id] )	
		respond_with @video.update(video_params)	
	end

	def destroy
		# video = Video.find( params[:id] )
		respond_with @video.destroy
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
	    def set_video
	      @video = Video.find(params[:id])
	    end

		def video_params
	  		params.require(:video).permit(:title, :year, :imdb, :genre, :actors, :rating, :poster, :filename, 
  				:folder, :size, :status, :deleted, :is3D, :attachments,
  				:id, :created_at, :updated_at
  			)
		end


end
