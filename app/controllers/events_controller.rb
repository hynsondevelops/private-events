class EventsController < ApplicationController
	def new
		@event = Event.new
	end

	def create
		current_user = User.find_by(name: cookies[:signedInUserName])
		@event = current_user.created_events.build(event_params)
		if @event.save
			redirect_to action: "show", id: @event.id
		end
	end

	def show
		@event = Event.find(params[:id])
	end

	def index
		@events = Event.all
		@previous = []
		@upcoming = []
		@events.each do |current_event|
			if (current_event.date < DateTime.now)
				@previous.append(current_event)
			else
				@upcoming.prepend(current_event)
			end
		end
	end

	private

	    def event_params
	      params.require(:event).permit(:name, :date)
	    end

end
