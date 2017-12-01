class PackageDecorator < Draper::Decorator
  delegate_all

  def description
    humanized_description
  end

  # @return A tweet about the package or nil if there isn't a description
  def to_tweet(linkLength: 23, tweetMaxLength: 280)
    return if self.description.include? Package::DESCRIPTION_UNAVAILABLE

    head = "#{ self.name.sub("@","") }:" # Remove @ from scoped names to prevent mentions
    desc = CGI.unescapeHTML self.description.gsub("\n", ' ').gsub(/\s+/, ' ').strip.sub(/\.$/, '')
    link = "https://github.com/#{ self.repo }"
    descMaxLength = tweetMaxLength - linkLength - head.length - 2 # spaces
    desc = desc.first(descMaxLength - 1) + "…" if desc.length > descMaxLength

    return "#{ head } #{ desc } #{ link }"
  end
end
