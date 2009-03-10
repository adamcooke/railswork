module ActsAsUser
	def self.included(base)
		base.extend ClassMethods
	end
	
	module ClassMethods
		def acts_as_user(options = {})
			return if self.included_modules.include?(ActsAsUser::ActMethods)
			send :include, ActsAsUser::ActMethods
			
			cattr_accessor :user_salt
			self.user_salt = USER_SALT || "enter_a_salt"
			
			validates_presence_of :username, :forename, :surname, :email
			validates_uniqueness_of :username
			validates_numericality_of :access_level
			
		
		end
	end	
		
	module ActMethods
			
		def self.included(base)
			base.extend ClassMethods
		end

		def validate
			errors.add_to_base("User must have a password") if self.hashed_password.blank?
		end

		def allowed?(required)
			result = required & self.access_level
	  	result == 0 ? false : true
		end
	
		def name(display = :first_and_last)	
			forename = self.forename.capitalize
			surname = self.surname.capitalize
			case display
				when :first
					forename
				when :surname
					surname
				when :first_and_last
					[forename, surname].join(" ")
				when :last_and_first
					[surname, forename].join(", ")
				when :first_and_last_initial
					[forename, surname[0,1]].join(" ")
				when :initials
					[forename[0,1], surname[0,1]].join
			end	
		end
		
		def password
			@password
		end
		
		def password=(pwd)
			if !pwd.blank?
				@password = pwd
				create_new_salt
				self.hashed_password = User.encrypted_password(self.password, self.salt)
			else
				self.hashed_password = self.hashed_password
			end
		end
	
	
		def create_new_password_key
			randomness = self.object_id.to_s + rand.to_s
			self.reset_password_key = Digest::SHA1.hexdigest(randomness)
			self.reset_password_expiry = Time.now.tomorrow
		end
		
		def clear_password_reset_key
			self.reset_password_key = nil
			self.reset_password_expiry = nil
		end
	
		def create_autologin_token
			randomness = self.object_id.to_s + rand.to_s
			token = Digest::SHA1.hexdigest(randomness)
			self.auto_login_token = token
			return token
		end
	
		private
		
		def create_new_salt
			self.salt = Digest::SHA1.hexdigest(self.object_id.to_s + rand.to_s)
		end
		
			
		module ClassMethods
			def encrypted_password (password, salt)
				string_to_hash = password + USER_SALT + salt
				Digest::SHA1.hexdigest(string_to_hash)
			end
			
			def authenticate(username, password, options = {})	
				user = User.find(:first, :conditions => ["username = ?", username])
				if user
					expected_password = encrypted_password(password, user.salt)
					if user.hashed_password != expected_password
						user = nil
					end
				end
				user
			end
			
		end
	end
end