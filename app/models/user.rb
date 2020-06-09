require 'securerandom'

class User < ApplicationRecord
  validates :email, uniqueness: true

  has_secure_password

  def generate_api_key
    self.api_key = SecureRandom.urlsafe_base64
  end
end
