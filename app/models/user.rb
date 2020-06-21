class User < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true ,uniqueness: true
    validates :password, presence: true, length: {minimum: 5}
    validates :password, confirmation:{case_sensitive: true}
    has_secure_password
    has_many :emails
end
