class Api::V1::LinksController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    link = current_user.links.create(link_params)
    render status: 201, json: {
      message: "Successfully created a link.",
      link: link
    }.to_json
  end

  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(link_params)
      render json: @link
    else
      render json: @link.errors.full_messages, status: 500
    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :url, :read, :user_id).merge(user_id: current_user.id)
  end

end
