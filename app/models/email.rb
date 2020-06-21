#this file tells us about many to one relation an email has with a user, where a user can have multiple emails
class Email < ApplicationRecord
    belongs_to :user, optional: true
end
