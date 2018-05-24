class Admin::SlidesController < Admin::BaseController
  before_action :find_slide, only: %i(edit update destroy)

  def new
    @slide = Slide.new
  end

  def create
    @slide = Slide.new slide_params
    if @slide.save
      flash[:success] = t "flash.create_slide_succeed"
      redirect_to admin_slides_path
    else
      render :new
    end
  end

  def index
    @slides = Slide.page(params[:page]).per Settings.slides.limit_page
  end

  def update
    if @slide.update_attributes slide_params
      flash[:success] = t "flash.update_slide_succeed"
      redirect_to admin_slides_path
    else
      render :edit
    end
  end

  def edit; end

  def destroy
    if @slide.destroy
      flash[:success] = t "flash.delete_slide_succeed"
    else
      flash[:danger] = t "flash.delete_slide_failed"
    end
    redirect_to admin_slides_path
  end

  private

  def slide_params
    params.require(:slide).permit :title, :image, :link
  end

  def find_slide
    @slide = Slide.find_by id: page[:id]
    return if @slide
    flash[:danger] = "flash.not_found_slide"
    redirect_to admin_slides_path
  end
end
