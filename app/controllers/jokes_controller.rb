class JokesController < ApplicationController

	def index
		@joke = Joke.order("RANDOM()").first
	end

	def new
		@joke = Joke.new
	end

	def create
		Joke.create(joke_params)
		redirect_to root_path
	end

 	private


  	def joke_params
    	params.require(:joke).permit(:saying, :author, :title)
  	end

end
