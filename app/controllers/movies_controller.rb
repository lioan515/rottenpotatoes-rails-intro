class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #get a hash of all the ratings
    @all_ratings = Movie.get_ratings
     
    if params[:sort]
      @sort_sesh = params[:sort]
      session[:sort] = @sort_sesh
    else
      @sort_sesh = session[:sort] || []
    end
     
    if params[:ratings]
      @checked_ratings = params[:ratings]
      session[:ratings] = @checked_ratings
    else
      @checked_ratings = session[:ratings] || @all_ratings
    end
    
    if !params[:ratings] || (!params[:sort] && @sort_sesh != [])
      flash.keep
      redirect_to :action=> 'index', :sort=> @sort_sesh, :ratings=> @checked_ratings
    end
    
    #sort and filter
    if params[:sort]
      @movies = Movie.where(:rating => @checked_ratings.keys).order(@sort_sesh)
    else
      @movies = Movie.where(:rating => @checked_ratings.keys)
    end
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
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
