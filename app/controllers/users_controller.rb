class UsersController < ApplicationController
	before_action :find_user, only:[:show, :edit, :update]
	
	def index
		@users = User.all.order("created_at")
	end

	def show
	end

	def edit
	end

	def update
		if @user.update user_params
			redirect_to @user, success: 'User was updated'
		else
			render 'edit', danger: 'User was not updated'
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :first_name, :last_name, :country, :state, :city, :street, :zip, :admin, :moderator)
	end

	def find_user
		@user = User.find(params[:id])
	end
end