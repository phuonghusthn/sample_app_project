class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.valid_email_regex

  before_save{email.downcase!}

  validates :name, presence: true, length: {maximum: Settings.maximum_name}
  validates :email, presence: true,
    length: {maximum: Settings.maximum_email_length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: true
  validates :password, presence: true,
    length: {minimum: Settings.minimum_pass_length}

  has_secure_password
end
