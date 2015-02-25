class UsersController < ApplicationController

	def index
		if current_user
			@user = current_user
			# @user.posts.all
		else
    	redirect_to new_user_path, notice: "Please log in"
  	end
	end

	def new

	end

	def show

	end

	def home
		render 'home'
	end

	def profile_page
		render 'profile_page'
	end
end
