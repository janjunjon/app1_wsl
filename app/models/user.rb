class User < ApplicationRecord
	attr_accessor :remember_token
	validates :name, presence: true, length: { maximum: 20 }
	valid_format = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 200 }, format: { with: valid_format}, uniqueness: true
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
	validates :image, content_type: { in: %w[image/jpeg image/gif image/png image/svg], message: "フォーマットが対応していません。"},
					  size: { less_than: 5.megabytes, message: "ファイルサイズが大きすぎます。" }
	has_secure_password
	has_one_attached :image
	# mount_uploader :image, ImageUploader

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

	def resized_image
		self.image.variant(gravity: :center, resize:"80x80^", crop:"80x80+0+0").processed
		# image.variant(resize_to_limit: [500, 500])
	end
end
