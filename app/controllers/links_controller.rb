class LinksController < ApplicationController

  def index
    if current_user
      @links = current_user.links.order(created_at: :desc)
    else
      redirect_to login_path
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(link_params)
      flash[:success] = 'Link was updated successfully!'
      redirect_to root_path
    else
      flash.now[:danger] = "Oops, let's try that again"
      render :edit
    end
  end

  private

    def link_params
      params.require(:link).permit(:url, :title)
    end

end
