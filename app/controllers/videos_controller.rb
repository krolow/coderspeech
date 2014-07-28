class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  has_scope :sort

  # GET /videos
  # GET /videos.json
  def index
    logger.debug
    video = Video
    if params[:category]
      @category = Category.find(params[:category])
      if not @category
        raise ActionController::RoutingError.new('Not Found')
      end
      video = video.where(category_id: @category.id)
    end
    if params[:tag]
      @tag = params[:tag]
      video = video.tagged_with(params[:tag])
    end

    @total = video.count
    @videos = apply_scopes(video).includes(:category).published.page(params[:page])
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    # if not @video.view_grabber_working?
    #   Resque.enqueue(VideoViewsGrabberJob, @video.id)
    # end
  end

  # GET /videos/new
  def new
    @autocomplete_items = ActsAsTaggableOn::Tag.all
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(
        :title,
        :description,
        :video,
        :slide,
        :image,
        :category_id,
        :tag_list,
        :published,
        :date_of_video,
        :short_description,
        :featured
      )
    end
end
