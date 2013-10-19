class User < ActiveRecord::Base
  attr_accessible :email, :password, :session_token
  attr_reader :password

  validates :email, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, presence: true, on: :create
  validates :password_digest, presence: true

  has_many :goals

  before_validation :ensure_session_token

  def self.find_by_credentials(email, password)
  	user = User.find_by_email(email)
  	return nil unless user

  	user.is_password?(password) ? user : nil
  end

  def password=(password)
  	self.password_digest = BCrypt::Password.create(password)
  	@password = password
  end

  def is_password?(password)
  	BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
  	self.session_token = User.generate_session_token
    self.save!
  end

  def self.generate_session_token
  	SecureRandom.urlsafe_base64(16)
  end

  private

	  def ensure_session_token
	  	self.session_token ||= User.generate_session_token
	  end

end
