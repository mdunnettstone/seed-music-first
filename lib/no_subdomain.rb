class NoSubdomain
  def self.matches?(request)
    request.subdomain(1).blank? || request.subdomain(1) == 'www'
  end
end