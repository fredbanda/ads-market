class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships

  has_secure_password
  validates :password,
            presence: true,
            length: { minimum: 6, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED }

  before_validation :strip_whitespace

  private

  def strip_whitespace
    self.name = self.name&.strip
    self.email = self.email&.strip
  end
end
