module JokesHelper

  	def joke_params
    	params.require(:joke).permit(:saying, :author, :title)
  	end


end
