class User < ApplicationRecord
	attr_accessor :remember_token
	validates :name, presence: true, length: { maximum: 20 }
	valid_format = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 200 }, format: { with: valid_format}, uniqueness: true
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
	has_secure_password
	has_one_attached :image

	def self.mk_token
		SecureRandom.urlsafe_base64
	end

	def self.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	def remember
		self.remember_token = User.mk_token
		self.update_columns(remember_digest: User.digest(remember_token), updated_at: Time.zone.now)
	end

	def forget
		self.update_attribute(:remember_digest, nil)
	end

	def authenticated?(token)
		BCrypt::Password.new(remember_digest).is_password?(token)
	end
end
