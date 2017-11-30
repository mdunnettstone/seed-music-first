class HasSubdomain
  def self.matches?(request)
    request.subdomain(1).present? && request.subdomain(1) != 'www'
  end
end