class Article < ApplicationRecord
    validates :title, presence: true, uniqueness: true
    validates :author, presence: true
    validates :year, presence: true, numericality: {only_integer: true, less_than_or_equal_to: 2020}
    validates :abstract, presence: true, length: {minimum: 100}
    validates :degree, presence: true
    validates :romaji_name, presence: true
end
