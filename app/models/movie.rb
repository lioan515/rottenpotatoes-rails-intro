class Movie < ActiveRecord::Base
    def get_ratings
      Movie.order(:rating).pluck(:rating).uniq
    end
end
