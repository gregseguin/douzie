class Joke < ActiveRecord::Base
	has_many :taggings
	has_many :tags, through: :taggings
	acts_as_votable

	has_many :favorite_jokes
	has_many :favorited_by, through: :favorite_jokes, source: :user

	

	def to_param
		"#{id} #{title}".parameterize
	end

	def tag_list
		self.tags.collect do |tag|
			tag.name
		end.join(", ")
	end

	def tag_list=(tags_string)
  		tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
  		new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
  		self.tags = new_or_found_tags
	end
end
