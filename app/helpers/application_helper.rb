module ApplicationHelper

  def gravatar_url(user, size)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

  def markdown(blogtext)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new({hard_wrap: true, filter_html: true}), {autolink: true, no_intra_emphasis: true})
    markdown.render(blogtext).html_safe
  end

end
