class Tag < ActiveRecord::Base
	include FriendlyId
	friendly_id :name, use: :slugged
	validates_presence_of :name, :slug

	has_many :taggings
	has_many :jokes, through: :taggings

	def to_s
		name
	end

end
