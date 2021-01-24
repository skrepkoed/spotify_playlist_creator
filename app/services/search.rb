

class Search

	def self.with_genre(searh_request, artists,result)

		if searh_request

              artist=[]
              searh_request.split.each do |genre|
                #binding.pry
                artist<<artists.select{|artist| artist.genres.map(&:split).flatten.include?(genre)}
              end
              searh_request=nil
              artist.sort!{|i| i.length}.reverse!
              artist=artist.inject(artist[0]){|memo,e| memo=memo | e }
              #binding.pry
              
              if artist.empty?
                artists 
                result=:empty
              else
                result=:success
                artists=artist
              end
            else
              artists
             
            end
		
	end


end