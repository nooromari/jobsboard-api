class User < ApplicationRecord
    # encrypt password
    has_secure_password

    has_many :applications, foreign_key: :applier_id, dependent: :destroy
    validates_presence_of :email, :password_digest    
end
