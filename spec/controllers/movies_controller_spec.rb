require 'spec_helper'

describe MoviesController do
  describe 'finding movies with same director' do
    before :each do
      @one_fake_result = [mock('Movie')]
      @fake_results = [mock('Movie'), mock('Movie')]
    end
    it 'should call the model method that performs TMDb search' do
      Movie.should_receive(:find_id_in_TMDb).with("2").
        and_return(@one_fake_results)
      post :similar, {:id => 2}
    end
    describe 'after valid search' do
      before :each do
        Movie.stub(:find_director_in_TMDb).and_return(@fake_results)
        post :similar, {:id => 2}
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