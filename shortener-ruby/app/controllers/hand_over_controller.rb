class HandOverController < ApplicationController
  def index
    url = Url.find_by shortLink: params[:user_link]
    if url.present?
      redirect_to url.originalLink
    else
      render json: {
          error: "Invalid short link, please try again"
      }
    end
  end

end
