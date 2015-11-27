class TagsController < ApplicationController

  before_filter :require_login, only: [:destroy]


def show
	@tag = Tag.friendly.find(params[:id])
end

def index
	@tags = Tag.all.order('name ASC')
end


end
