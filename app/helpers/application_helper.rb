module ApplicationHelper
  def markdown
    @_markdown ||= Redcarpet::Markdown.new Redcarpet::Render::HTML.new(escape_html: true)
  end

  # Removes markdown syntax by rendering to HTML and stripping the tags
  def plain_text(text)
    strip_tags(markdown.render(text.to_s)).strip
  end
end
