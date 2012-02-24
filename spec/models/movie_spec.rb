require 'spec_helper'

describe Movie do
  describe 'searching Tmdb by ID' do
    it 'should call Tmdb with ID' do
      Movie.should_receive(:find_by_id).
        with("1")
      Movie.find_id_in_TMDb("1")
    end
  end
  
  describe 'searching Tmdb for all movies with same director' do
    it 'should call Tmdb with director' do 
      @one_fake_result = mock('Movie')
      @one_fake_result.stub(:director).and_return('Tom Cruise')
      @one_fake_result.stub(:id).and_return(1)
      @fake_results = [@one_fake_result, @one_fake_result]
      
      Movie.should_receive(:find_id_in_TMDb).with("1").
        and_return(@one_fake_result)
      #@one_fake_result.should_receive(:director).and_return("Tom Cruise")  
        
      Movie.should_receive(:find_by_director).
        with("Tom Cruise")
      
      Movie.find_all_by_director("Tom Cruise")
    end
  end  
end