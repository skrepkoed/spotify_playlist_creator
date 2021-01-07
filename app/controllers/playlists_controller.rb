class PlaylistsController < ApplicationController
  before_action :require_login, :current_user
  def index

  	#@user=User.find session[:user_id]

  	@playlists=@user.playlists

  	
  end

  def new
  @playlist=Playlist.new
  
  @list=Playlist.list(session[:user_id],:artists)
  
  @artists=SpotifyResponceArtists.new(@list).filtred_responce{|artist| [artist.name, artist.id, artist.genres.to_s] }
  
  end

  def create

	params[:playlist][:user_id]=session[:user_id]
		
	options=Playlist.create(playlist_params)	
	playlist=RandomPlaylist.generate(options)


	redirect_to user_path session[:user_id]
  end

  def albums  
  @list=Playlist.list(session[:user_id],:albums,params)
  
  @albums=SpotifyResponceItems.new(@list).filtred_responce{|album| [album.name, album.id] }
  
  end

  def tracks
  @list=Playlist.list(session[:user_id],:songs, params)
  
  @songs=SpotifyResponceItems.new(@list).filtred_responce{|song| song.name }
  	
  end

  private

  def playlist_params

  	params.require(:playlist).permit(:playlist_name, :number_artists,:number_albums, :number_songs,:user_id)
  	
  end

end
