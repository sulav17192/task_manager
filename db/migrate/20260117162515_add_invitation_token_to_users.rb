class AddInvitationTokenToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :invitation_token, :string
    add_column :users, :confirmed_at, :datetime
  end
end
