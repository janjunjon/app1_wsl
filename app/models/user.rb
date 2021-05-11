class User < ApplicationRecord
	attr_accessor :remember_token, :activation_token, :password_reset_token
	validates :name, presence: true, length: { maximum: 20 }
	valid_format = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 200 }, format: { with: valid_format}, uniqueness: true
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
	validates :image, content_type: { in: %w[image/jpeg image/gif image/png image/svg], message: "フォーマットが対応していません。"},
					  size: { less_than: 5.megabytes, message: "ファイルサイズが大きすぎます。" }
	has_secure_password
	has_one_attached :image
	# mount_uploader :image, ImageUploader
	before_create :activation

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

	def resized_image(size)
		self.image.variant(gravity: :center, resize:"#{size}x#{size}^", crop:"#{size}x#{size}+0+0").processed
		# image.variant(resize_to_limit: [500, 500])
	end

	def activation
		self.activation_token = User.mk_token
		self.update_columns(activation_digest: User.digest(activation_token), activated_at: Time.zone.now)
		# self.activation_digest = User.digest(activation_token)
	end

	def password_reset
		self.password_reset_token = User.mk_token
		self.update_attribute(:password_reset_digest, User.digest(password_reset_token))
		# if self.password_reset_digest.nil?
		# 	self.password_reset_digest = User.digest(password_reset_token)
		# else
		# 	self.update_attribute(:password_reset_digest, User.digest(password_reset_token))
		# end
	end

	def authenticated?(attribute, token)
		digest = self.send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	def send_email(mailtype)
		# UserMailer.send("#{mailtype}", self).deliver_now
	end

	def account_activation_mail
		UserMailer.account_activation(self, self.activation_token).deliver_now
	end

	def activate_user
		self.update_columns(activated: true, activated_at: Time.zone.now)
	end

	def escape_email
		CGI.escape(self.email)
	end
end
