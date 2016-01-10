class JokesController < ApplicationController

	def index
		@joke = Joke.order("RANDOM()").first
		@tags = Tag.all.order('name ASC')
	end

	def new
		@joke = Joke.new
	end

	def create
		@joke = Joke.new(joke_params)
		@joke.save

		flash.notice = "Joke Created!"

		redirect_to joke_path(@joke)
	end

	def show
		@joke = Joke.find(params[:id])
	end

	def destroy
		@joke = Joke.find(params[:id])
		@joke.destroy

		flash.notice = "Joke Deleted!"

		redirect_to root_path
	end

	def edit
  		@joke = Joke.find(params[:id])
	end

	def update
  		@joke = Joke.find(params[:id])
  		@joke.update(joke_params)

  		flash.notice = "Joke Updated!"

  		redirect_to joke_path(@joke)
	end

	def privacy
	end

 	private

 	def joke_params
    	params.require(:joke).permit(:saying, :author, :title, :tag_list)
  	end


end
