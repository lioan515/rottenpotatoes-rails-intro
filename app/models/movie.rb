class Movie < ActiveRecord::Base
    
    class << self 
      def get_ratings
        Movie.order(:rating).pluck(:rating).uniq
      end
    end
   
end
