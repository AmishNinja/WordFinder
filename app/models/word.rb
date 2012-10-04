class Word < ActiveRecord::Base
	validates_presence_of :name, :count
end
