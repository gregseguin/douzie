class JokesController < ApplicationController

	def after_sign_in_path_for(resource)
    	request.env['omniauth.origin'] || stored_location_for(resource) || root_path
    end

	def index
		@joke = Joke.limit(5).order("RANDOM()").last
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
		@favorited = FavoriteJoke.find_by(user: current_user, joke: @joke).present?
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

  # Add and remove favorite jokes
  # for current_user
  def favorite
  	@joke = Joke.find(params[:id])
    type = params[:type]
    if type == "favorite"
      current_user.favorites << @joke
      redirect_to :back, notice: 'Added to favorites'

    elsif type == "unfavorite"
      current_user.favorites.delete(@joke)
      redirect_to :back, notice: 'Removed from favorites'

    else
      # Type missing, nothing happens
      redirect_to :back, notice: 'Nothing happened.'
    end
  end


	#upvote from user
	def upvote
		@joke = Joke.find(params[:id])
		@joke.upvote_from current_user
		respond_to do |format|
			format.html {redirect_to :back}
			format.json { render json: { count: @joke.get_upvotes.size } }
		end
	end

	#downvote from user
	def downvote
		@joke = Joke.find(params[:id])
		@joke.downvote_from current_user
		respond_to do |format|
			format.html {redirect_to :back}
			format.json { render json: { count: @joke.get_downvotes.size } }
		end
	end

	def privacy
	end

 	private

 	def joke_params
    	params.require(:joke).permit(:saying, :author, :title, :tag_list)
  	end


end
