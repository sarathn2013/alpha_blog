class User < ActiveRecord::Base
	has_many  :articles, dependent: :destroy

	before_save {self.email = email.downcase }
	validates  :username, presence: true,
			   uniqueness: {case_sensitive: false}, 
			   length: {minimum: 3, maximum: 20 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, 
	           uniqueness: {case_sensitive: false}, 
	           length: {maximum: 105}, 
	           format: {with: VALID_EMAIL_REGEX}
	has_secure_password
	PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
/x
	validates :password, length: {minimum: 8, maximum: 20}, format: {with: PASSWORD_FORMAT}
end
