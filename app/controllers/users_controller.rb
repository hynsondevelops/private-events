class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save #successful
			redirect_to action: "show", id: @user.id
		else
			#unsucessful
		end
	end

	def show 
		@user = User.find(params[:id])
	end

	def signin
		@signedInUser = User.find_by(name: params[:name])
		if (@signedInUser == nil)
			redirect_to action: "show", id: 1
		end
		cookies[:signedInUserName] = @signedInUser.name
	end

	private

		def user_params
		  params.require(:user).permit(:name)
		end

end
