class User < ApplicationRecord
	validates :name, presence: true, length: { maximum: 20 }
	valid_format = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 200 }, format: { with: valid_format}, uniqueness: true
	validates :password, presence: true, length: { minimum: 6 }
	has_secure_password
end
