class AddCoinsUsedToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :coins_used, :integer, default: 0
  end
end
