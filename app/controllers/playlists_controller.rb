class PlaylistsController < ApplicationController
  def index

  	@user=User.find session[:user_id]

  	@playlists=@user.playlists

  	
  end

  def new
  @playlist=Playlist.new
  @user=User.find session[:user_id]
  token=@user.token.access_token
  @playlist.configure_artist(token,nil)
  @artists=SpotifyResponceArtists.new(@playlist).responce 
  @artists.map!{|artist| [artist.name, artist.id] }
  
  end

  def create

	params[:playlist][:user_id]=session[:user_id]
		
	options=Playlist.create(playlist_params)	
	playlist=RandomPlaylist.generate(options)


	redirect_to user_path session[:user_id]
  end

  def albums  
  @playlist=Playlist.new
  @user=User.find session[:user_id]
  token=@user.token.access_token
  @playlist.configure_item(token,nil)

  @playlist.item_option.items_id=[params[:id]]
  @playlist.item_option.endpoint= :albums
  #binding.pry
  @albums=SpotifyResponceItems.new(@playlist).responce_total.flatten
  
  @albums.map!{|album| [album.name, album.id] }
  end

  def tracks
  @playlist=Playlist.new
  @user=User.find session[:user_id]
  token=@user.token.access_token
  @playlist.configure_item(token,nil)

  @playlist.item_option.items_id=[params[:id]]
  @playlist.item_option.endpoint= :songs
  #binding.pry
  @songs=SpotifyResponceItems.new(@playlist).responce_total.flatten
  
  @songs.map!{|song| song.name }
  	
  end

  private

  def playlist_params

  	params.require(:playlist).permit(:playlist_name, :number_artists,:number_albums, :number_songs,:user_id)
  	
  end

end
