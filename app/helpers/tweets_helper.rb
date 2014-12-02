module TweetsHelper
  def url_to_anchor content
    content.gsub /(https?:\/\/\S+)/ do |match|
      link_to(match, match, target: '_blank')
    end
  end
end
