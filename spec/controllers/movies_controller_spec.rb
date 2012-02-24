require 'spec_helper'

describe MoviesController do
  describe 'finding movies with same director' do
    before :each do
      @one_fake_result = mock('Movie')
      @one_fake_result.stub(:director).and_return('Tom Cruise')
      @one_fake_result.stub(:id).and_return(1)
      @fake_results = [@one_fake_result, @one_fake_result]
      
      Movie.should_receive(:find_id_in_TMDb).with("1").
        and_return(@one_fake_result)
    end
    it 'should call the model method that performs TMDb search by id' do
      #Movie.should_receive(:find_id_in_TMDb).with("1").
        #and_return(@one_fake_result)
      post :similar, {:id => 1}
    end
    it 'should call the model method that performs TMDb search by director' do
      #Movie.should_receive(:find_id_in_TMDb).with("1").
        #and_return(@one_fake_result)
      Movie.should_receive(:find_director_in_TMDb).with('Tom Cruise').
        and_return(@fake_results)
      post :similar, {:id => 1}
    end
    describe 'after valid search' do
      before :each do
        Movie.stub(:find_director_in_TMDb).and_return(@fake_results)
        post :similar, {:id => 1}
      end
      it 'should select the Search Results template for rendering' do
        response.should render_template('similar')
      end
      
      it 'should make the TMDb search results available to that template' do
        assigns(:movies).should == @fake_results
      end
    end
  end
end