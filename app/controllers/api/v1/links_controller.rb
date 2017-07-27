class Api::V1::LinksController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    link = current_user.links.new(link_params)
    if link.save
      render status: 201, json: {
        message: "Successfully created a link.",
        link: link
      }.to_json
    else
      render status: 404, json: {
        message: "Not a valid URL."
      }.to_json
    end
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
      params.require(:link).permit(:title, :url, :read).merge(user_id: current_user.id)
    end

end
