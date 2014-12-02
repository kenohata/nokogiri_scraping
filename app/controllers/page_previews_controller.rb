class PagePreviewsController < ApplicationController
  before_filter :require_login

  def create
    begin
      uri  = URI.parse(params_page_preview[:url])
      file = open uri
      html = Nokogiri::HTML(file)

      title = if el = html.at_css('meta[name="og:title"]')
        el.attr('content')
      elsif el = html.at_css('meta[property="og:title"]')
        el.attr('content')
      elsif el = html.at_css("title")
        el.text
      end

      url = if el = html.at_css('meta[property="og:url"]')
        el.attr('content')
      elsif el = html.at_css('meta[property="og:url"]')
        el.attr('content')
      else
        uri.to_s
      end

      image = if el = html.at_css('meta[property="og:image"]')
        el.attr('content')
      elsif el = html.at_css('meta[property="og:image"]')
        el.attr('content')
      end

      json = {
        title: title,
        url: url,
        image: image,
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
