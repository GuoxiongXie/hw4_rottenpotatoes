class MoviesController < ApplicationController
  
  #q3 scenario 2
  def similar
    @id = params[:id]
    #debugger #check id
    @movie = Movie.find_id_in_TMDb(@id)
    
    #change starts from here
    #if @movie != nil  #valid search
      @director = @movie.director

      if @director != ""
        @movies = Movie.find_director_in_TMDb(@director) #should be model method???
      else
        redirect_to movies_path(:noDirector => @id)
      end
    #end    
    #debugger
  end
  #end of q3 scenario 2 

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    sort = params[:sort] || session[:sort]
    case sort
    when 'title'
      ordering,@title_header = {:order => :title}, 'hilite'
    when 'release_date'
      ordering,@date_header = {:order => :release_date}, 'hilite'
    end
    @all_ratings = Movie.all_ratings
    @selected_ratings = params[:ratings] || session[:ratings] || {}

    if params[:sort] != session[:sort]
      session[:sort] = sort
      redirect_to :sort => sort, :ratings => @selected_ratings and return
    end

    if params[:ratings] != session[:ratings] and @selected_ratings != {}
      session[:sort] = sort
      session[:ratings] = @selected_ratings
      redirect_to :sort => sort, :ratings => @selected_ratings and return
    end
    
    
    #I added this one!!
    if params.has_key?(:noDirector)
      theID = params[:noDirector]
      theMovie = Movie.find_by_id(theID)
      theMovieTitle = theMovie.title
      flash[:error] = "'#{theMovieTitle}' has no director info" #need '' around name?? 
      #theMovie.save! #save in database
      #debugger
    end
    #end of adding
    @movies = Movie.find_all_by_rating(@selected_ratings.keys, ordering)
    #debugger
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
