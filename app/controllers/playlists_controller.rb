class PlaylistsController < ApplicationController
  def index

  	@user=User.find session[:user_id]

  	@playlists=@user.playlists

  	
  end

  def new

  @playlist=Playlist.new
  end

  def create

	params[:playlist][:user_id]=session[:user_id]
		
	options=Playlist.create(playlist_params)	
	playlist=RandomPlaylist.generate(options)


	redirect_to user_path session[:user_id]
  end

  def albums
  	
  end

  def tracks
  	
  end

  private

  def playlist_params

  	params.require(:playlist).permit(:playlist_name, :number_artists,:number_albums, :number_songs,:user_id)
  	
  end

end
