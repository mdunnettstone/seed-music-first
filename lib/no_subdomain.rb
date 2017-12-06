class NoSubdomain
  def self.matches?(request)
    tld_length = Rails.env.production? ? 2 : 1
    request.subdomain(tld_length).blank? || request.subdomain(tld_length) == 'www'
  end
end