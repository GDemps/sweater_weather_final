class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :api_key, uniqueness: true, presence: true
  has_secure_password
  before_validation :set_api_key

  private
  def set_api_key
    self.api_key = SecureRandom.uuid
  end
end
