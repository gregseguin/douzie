class TagsController < ApplicationController

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || request.referrer || root_path
  end

  def show
	@tag = Tag.friendly.find(params[:id])
  end

  def index
	@tags = Tag.all.order('name ASC')
  end


end
