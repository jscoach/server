class PackageDecorator < Draper::Decorator
  delegate_all

  DESCRIPTION_UNAVAILABLE = "No description available."

  # Make some minor transformations to the description before displaying it
  # If unavailable, default to `original_description`
  def description
    desc = object.description.to_s
    desc = h.strip_tags(markdown.render(desc)).strip # Escape HTML and remove Markdown

    if desc.blank? or ["[!", "[](", "===", "```"].any? { |s| desc.include? s }
      "<em>#{ DESCRIPTION_UNAVAILABLE }</em>".html_safe
    else
      desc = "#{ desc }." if /\w/ =~ desc.last # Add trailing dot
      desc[0] = desc[0].upcase # Capitalize 1st letter
      desc.html_safe
    end
  end

  # @return A tweet about the package or nil if there isn't a description
  def to_tweet(linkLength: 23, tweetMaxLength: 280)
    return if self.description.include? DESCRIPTION_UNAVAILABLE

    head = "#{ self.name.sub("@","") }:" # Remove @ from scoped names to prevent mentions
    desc = CGI.unescapeHTML self.description.gsub("\n", ' ').gsub(/\s+/, ' ').strip.sub(/\.$/, '')
    link = "https://github.com/#{ self.repo }"
    descMaxLength = tweetMaxLength - linkLength - head.length - 2 # spaces
    desc = desc.first(descMaxLength - 1) + "…" if desc.length > descMaxLength

    return "#{ head } #{ desc } #{ link }"
  end

  private

  def markdown
    @_markdown ||= Redcarpet::Markdown.new Redcarpet::Render::HTML.new(escape_html: true)
  end
end
