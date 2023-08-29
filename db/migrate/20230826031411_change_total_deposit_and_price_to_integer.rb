class ChangeTotalDepositAndPriceToInteger < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :total_deposit, :integer, default: 0
    change_column :winners, :price, :integer, default: 0
  end
end
