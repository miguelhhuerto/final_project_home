class RenameCoinInOfferAndOrder < ActiveRecord::Migration[7.0]
  def change
    rename_column :orders, :coin, :coins
    rename_column :offers, :coin, :coins
  end
end
