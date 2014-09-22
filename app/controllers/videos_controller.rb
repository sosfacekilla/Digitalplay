class VideosController < ApplicationController

  before_action :authenticate_user!, :except => [:show]

	def index
  	@videos = Video.order('created_at DESC')
  end

	def new
  	@video = Video.new
	end
 
	def create
  	@video = Video.new(params.require(:video).permit(:link))
  	if @video.save
    	flash[:success] = 'Video added!'
    	redirect_to root_url
  	else
    	render 'new'
  	end
	end

  def show
    @videos = Video.order('created_at DESC')
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    redirect_to videos_path
  end

end
