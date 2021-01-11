class PlaylistsController < ApplicationController
  before_action :require_login, :current_user
  def index

  	#@user=User.find session[:user_id]

  	@playlists=@user.playlists

  	
  end

  def new
  @playlist=Playlist.new
  
  @list=Playlist.list(session[:user_id],:artists)
  
  
  @artists=SpotifyResponceArtists.new(@list).responce
  
  end

  def create

  #paths={'Pick an Artist'=> artist_playlists_path,'Pick an Album'=>album_playlists_path}
  
  #playlist_options.delete :endpoint
  
  options=Playlist.create(playlist_params) 
  #binding.pry 
  playlist=RandomPlaylist.generate(options)   
  redirect_to user_path session[:user_id]
  end

  def albums
  
  tree
  @albums 
  #binding.pry
  end

  def songs	
  tree
  end

  private

  def playlist_params
    
    params[:playlist][:user_id]=session[:user_id]
    
  	params.require(:playlist).permit(:playlist_name, :number_artists,:number_albums, :number_songs,:user_id,:endpoint, spotify_ids:[])
  	
  end

  def tree(path=nil)
    params[:playlist][:endpoint]=params[:action]
    params=playlist_params

    
    if params[:spotify_ids]&&(params[:number_albums]!=''||params[:number_songs]!='')
    
      elsif params[:spotify_ids]
        
        params[:spotify_ids].delete_if{|i| i=='' }
        
        @playlist=Playlist.new
        @list=Playlist.list(session[:user_id],params[:endpoint].to_sym,params)
        
        @albums=SpotifyResponceItems.new(@list).responce_total 

        



      elsif params[:number_artists]==''||params[:number_albums]==''||params[:number_songs]==''

        options=Playlist.create(playlist_params)  
        playlist=RandomPlaylist.generate(options)


      else
        ###default params
        options=Playlist.create(playlist_params)  
        playlist=RandomPlaylist.generate(options)            

    end
    
  end

end
