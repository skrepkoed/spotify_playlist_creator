class PagesController < ApplicationController
before_action :current_user
	#skip_before_action :require_login, except:[:welcome]
	def welcome
		
	end
end
