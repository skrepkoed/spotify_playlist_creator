

class SpotifyResponce
attr_accessor :type , :responce, :cursor, :total

def initialize(responce)
	@user=responce.delete(:user)
	@type=responce.keys[0]
	@responce=responce[@type]['items']
	@cursor=responce [@type]['cursors']['after']
	@total=responce[@type]['total']

	self.next_page

	
end

def next_page

	if @total>@responce.length

		self.add_next_page( SpotifyApiCall.call( user:@user, cursor:@cursor) )

		self.next_page
		
	end

	
	
end

def add_next_page(responce)
	@type=responce.keys[0]
	@responce+=responce[@type]['items']
	@cursor=responce [@type]['cursors']['after']
	
end

end