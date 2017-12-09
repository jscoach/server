module Donation
  START_URL_RE = /\/(?:www\.)?/
  END_URL_RE = /[^\"\#]+/

  PATREON_RE = /#{ START_URL_RE }(patreon\.com\/#{ END_URL_RE })/
  OPENCOLLECTIVE_RE = /#{ START_URL_RE }(opencollective\.com\/[^\"\#\/]+)/
  PAYPALME_RE = /#{ START_URL_RE }(paypal\.me\/#{ END_URL_RE })/
  PAYPALCOM_RE = /#{ START_URL_RE }(paypal\.com\/cgi\-bin\/webscr#{ END_URL_RE })/
  LIBERAPAY_RE = /#{ START_URL_RE }(liberapay\.com\/#{ END_URL_RE })/
  SALT_RE = /#{ START_URL_RE }(salt\.bountysource\.com\/#{ END_URL_RE })/

  # Grab the first donation link available in a given string
  def self.find_link(text)
    url = text[PATREON_RE, 1].presence || text[OPENCOLLECTIVE_RE, 1].presence ||
      text[PAYPALME_RE, 1].presence || text[PAYPALCOM_RE, 1].presence ||
      text[LIBERAPAY_RE, 1].presence || text[SALT_RE, 1]

    CGI.unescapeHTML("https://#{ url }") if url
  end
end
