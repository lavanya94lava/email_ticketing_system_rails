#here we set has_many association of user with email, also we put server side validations for creating a user
class User < ApplicationRecord
    validates :name, presence: true
    validates :password, presence: true, length: {minimum: 5}
    validates :password, confirmation:{case_sensitive: true}
    has_secure_password
    has_many :emails
end
