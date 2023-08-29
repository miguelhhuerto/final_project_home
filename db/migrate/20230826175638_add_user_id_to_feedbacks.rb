class AddUserIdToFeedbacks < ActiveRecord::Migration[7.0]
  def change
    add_column :feedbacks, :user_id, :string
  end
end
