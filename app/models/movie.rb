class Movie < ActiveRecord::Base
    
    def self.get_ratings
      self.order(:rating).pluck(:rating).uniq
    end
   
end
