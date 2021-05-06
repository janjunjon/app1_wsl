class News < ApplicationRecord
    validates :title, presence: true, length: { maximum: 6 }
    validates :contents, presence: true
    validates :info, presence: true
end
