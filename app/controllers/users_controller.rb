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
		@previous, @upcoming = ordered_events(@user)
	end

	def signin
		@signedInUser = User.find_by(name: params[:name])
		if (@signedInUser == nil)
			redirect_to action: "show", id: 1
		end
		cookies[:signedInUserName] = @signedInUser.name
	end

	def ordered_events(user)
		 if (user.created_events != nil || user.attended_events != nil)
		 	all_events = user.created_events + user.attended_events 
			all_events = all_events.sort_by {|current_event| current_event.date }
			previous = []
			upcoming = []
			all_events.each do |current_event|
				if (current_event.date < DateTime.now)
					previous.append(current_event)
				else
					upcoming.prepend(current_event)
				end
			end
			return previous, upcoming
		end
	end

	private

		def user_params
		  params.require(:user).permit(:name)
		end

end
