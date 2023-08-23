class CreateAdminInvites < ActiveRecord::Migration[7.0]
  def change
    create_table :admin_invites do |t|

      t.timestamps
    end
  end
end
