class Code < ApplicationRecord
    validates :classification, presence: true
    validates :password_digest, presence: true
    has_secure_password
end
