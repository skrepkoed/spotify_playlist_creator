class PlaylistsController < ApplicationController
  before_action :require_login, :current_user
def index
  @playlists=@user.playlists
end

def new

  @playlist=Playlist.new
  @list=Playlist.list(session[:user_id],:artists)
  @artists=SpotifyResponceArtists.new(@list).responce 
  #binding.pry
  
            if session[:search]

              artist=[]
              session[:search].split.each do |genre|
                #binding.pry
                artist<<@artists.select{|artist| artist.genres.map(&:split).flatten.include?(genre)}
              end
              session[:search]=nil
              artist.sort!{|i| i.length}.reverse!
              artist=artist.inject(artist[0]){|memo,e| memo=memo | e }
              #binding.pry
              
              if artist.empty?
                @artists 
                @result=:empty
              else
                @result=:success
                @artists=artist
              end
            else
              @artists
             
            end
            
           #binding.pry
           
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
  params[:playlist][:search]=nil if params[:playlist][:search]==''  
  params.require(:playlist).permit(:playlist_name, :number_artists,:number_albums, :number_songs,:user_id,:endpoint,:search, spotify_ids:[] )
end

def default_params(params)
  [:number_artists,:number_albums,:number_songs].each do |i|
    if params[i]==''
       params[i]=1
    end
  end
end

  def tree(path=nil)
    endpoint=params[:action].to_sym
    params=playlist_params
    params[:spotify_ids].map!{|e| SpotifyItem.new(JSON.parse(e))}
      if params[:search]
        session[:search]= params[:search]
        #binding.pry
        redirect_to new_playlist_path      
        elsif params[:spotify_ids][0]&&((params[:number_albums]!=''&&params[:number_albums])||(params[:number_songs]!=''&&params[:number_songs]))
          
          default_params(params)
          options=Playlist.create(params) 
          playlist=RandomPlaylist.generate(options)
          redirect_to user_path session[:user_id]
          
          elsif params[:spotify_ids][0]
            @playlist=Playlist.new
            @list=Playlist.list(session[:user_id],endpoint,params)  
            @albums=SpotifyResponceItems.new(@list).responce_total 
              
            elsif params[:number_artists]==''||params[:number_albums]==''||params[:number_songs]==''
              default_params(params)
              options=Playlist.create(params)  
              playlist=RandomPlaylist.generate(options)
              redirect_to user_path session[:user_id]
        
        else
          options=Playlist.create(playlist_params)  
          playlist=RandomPlaylist.generate(options)            
          redirect_to user_path session[:user_id]
        end
    
  end
end
