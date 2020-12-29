class PagesController < ApplicationController

	skip_before_action :require_login, execept:[:welcome]
	def welcome
		
	end
end
