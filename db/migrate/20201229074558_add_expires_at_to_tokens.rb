class AddExpiresAtToTokens < ActiveRecord::Migration[6.0]
  def change
    add_column :tokens, :expires_at, :integer
  end
end
