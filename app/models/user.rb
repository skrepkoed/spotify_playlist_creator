require 'bcrypt'
class User < ApplicationRecord

	has_secure_password
	has_one :token, dependent: :delete
end
