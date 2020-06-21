class Email < ApplicationRecord
    belongs_to :user, optional: true
end
