class JokesController < ApplicationController

	

	def joke_of_the_day
  		count = Joke.count

  		# This will make sure the joke is almost unique of this particular
  		# date. You can do more complexe calculation to make sure it's
  		# unique but you get the basic idea
  		sum_of_date = Date.today.year + Date.today.month + Date.today.day

  		# loop to make sure the sum_of_date is not greater than the count of jokes
  		new_count = loop do
    		if sum_of_date >= count
      			sum_of_date = sum_of_date / 2
    		else
     			 break (count - sum_of_date)
   			end
  		end

  		Joke.first(new_count).last
	end


	def index
		@joke = joke_of_the_day
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
