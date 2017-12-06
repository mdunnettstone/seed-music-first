class HasSubdomain
  def self.matches?(request)
    tld_length = Rails.env.production? ? 2 : 1
    request.subdomain(tld_length).present? && request.subdomain(tld_length) != 'www'
  end
end