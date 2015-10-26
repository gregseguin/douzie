class JokesController < ApplicationController

	def index
		@joke = Joke.first
	end

	def new
		@joke = Joke.new
	end

end
