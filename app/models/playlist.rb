class Playlist < ApplicationRecord
attr_accessor :artist_option, :item_option,  :playlist_option, :spotify_ids
	belongs_to :user

def self.list(user_id, type, params=nil)

	playlist=new
	user=User.find user_id
	token=user.token.access_token

	if type ==:artists

		playlist.configure_artist(token,nil)

		elsif type == :albums || type == :songs

			playlist.configure_item(token,nil)
			
			spotify_ids=params[:spotify_ids]
			
	 		playlist.item_option.items_id=spotify_ids
	 			
		 		case type
			 		when :albums then playlist.item_option.endpoint= :albums
			 		when :songs then playlist.item_option.endpoint= :songs 		
		 		end
				
			
	end

	playlist	
end

def initialize(params=nil)

	
	super(params)

	@spotify_ids=[]
	
	unless params==nil
		
		user=User.find params[:user_id]
		user=user 
		token=user.token.access_token
		spotify_user_id=user.token.spotify_user_id
		configure_artist(token, {artists:number_artists})
		configure_item(token, {albums:number_albums,songs:number_songs})
		@spotify_ids=params[:spotify_ids]
		configure_playlist(token,playlist_name,spotify_user_id) ###

	end

end


def configure_artist(token, params)
	artist_options={cursor:nil,token:token,number:params, endpoint: :artists, verb: :get} 
	 
	@artist_option=OpenStruct.new(artist_options)
	
end

def configure_item(token, params)
	item_options={offset:0,token:token,number:params, endpoint: nil, items_id:nil,current_item:nil, limit: 50,verb: :get}

	@item_option=OpenStruct.new(item_options)
end

def configure_playlist(token,params,spotify_user_id)

	playlist_options={token:token,name:params,spotify_user_id:spotify_user_id, verb: :post, playlist_id: nil, songs: nil}

	@playlist_option=OpenStruct.new(playlist_options)
	
end


end
