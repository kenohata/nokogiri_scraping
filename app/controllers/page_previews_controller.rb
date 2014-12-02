class PagePreviewsController < ApplicationController
  before_filter :require_login

  def create
    begin
      uri  = URI.parse(params_page_preview[:url])
      file = open uri
      html = Nokogiri::HTML(file)

      title = if el = html.at_css("title")
        el.text
      end

      url = uri.to_s

      json = {
        title: title,
        url: url,
      }

      render json: json
    rescue
      head :bad_request
    end
  end

  private

  def params_page_preview
    params.require(:page_preview).permit(:url)
  end
end
