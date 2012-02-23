class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.find_director_in_TMDb(theDirector)
    return self.find_all_by_director(theDirector)
  end
  
  #sad path
  def self.find_id_in_TMDb(theID)
    return self.find_by_id(theID)
  end
end
