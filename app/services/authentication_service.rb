class AuthenticationService
  def self.authenticate(email, password)
    user = User.find_by(email: email)
    return nil unless user&.authenticate(password)
    user
  end
end

