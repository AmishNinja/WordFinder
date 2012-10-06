class Word < ActiveRecord::Base
	validates_presence_of :name, :count, :site_id
	belongs_to :site

end
