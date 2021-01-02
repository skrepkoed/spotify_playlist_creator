class AddSpotifyUserIdToTokens < ActiveRecord::Migration[6.0]
  def change
    add_column :tokens, :spotify_user_id, :string
  end
end
