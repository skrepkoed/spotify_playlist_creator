class AddAssociationToTokensAndUsers < ActiveRecord::Migration[6.0]
  def change

  	add_reference :tokens, :user, foreign_key:  true
  end
end
