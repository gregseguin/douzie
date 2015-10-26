class JokesController < ApplicationController

	def index
		@joke = Joke.first
	end

end
