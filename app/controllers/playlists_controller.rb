class PlaylistsController < ApplicationController
  before_action :require_login, :current_user
def index
  @playlists=@user.playlists
end

def new
  @playlist=Playlist.new
  @list=Playlist.list(session[:user_id],:artists)
  @artists=SpotifyResponceArtists.new(@list).responce 
end

def create
  params=playlist_params
  params[:spotify_ids].map!{|e| SpotifyItem.new(JSON.parse(e))}
  options=Playlist.create(params) 
  playlist=RandomPlaylist.generate(options)   
  redirect_to user_path session[:user_id]
end

def albums
  tree
  @albums 
end

def songs	
  tree
end

  private

def playlist_params
  params[:playlist][:user_id]=session[:user_id]
  params[:playlist][:spotify_ids].delete_if{|i| i=='' } 
  params.require(:playlist).permit(:playlist_name, :number_artists,:number_albums, :number_songs,:user_id,:endpoint, spotify_ids:[])
end

def default_params
  params[:number_artists]||=1
  params[:number_albums]||=1
  params[:number_songs]||=1
end

def tree(path=nil)
  endpoint=params[:action].to_sym
  params=playlist_params
  params[:spotify_ids].map!{|e| SpotifyItem.new(JSON.parse(e))}
         
  if params[:spotify_ids][0]&&(params[:number_albums]!=''||params[:number_songs]!='')

    default_params
    elsif params[:spotify_ids][0]
      @playlist=Playlist.new
      @list=Playlist.list(session[:user_id],endpoint,params)  
      @albums=SpotifyResponceItems.new(@list).responce_total 
        
      elsif params[:number_artists]==''||params[:number_albums]==''||params[:number_songs]==''
        default_params
        options=Playlist.create(playlist_params)  
        playlist=RandomPlaylist.generate(options)
        
  else
    default_params
    options=Playlist.create(playlist_params)  
    playlist=RandomPlaylist.generate(options)            
    redirect_to user_path session[:user_id]
  end
end
end
