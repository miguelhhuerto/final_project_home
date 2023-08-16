class AddEnumToOfferGenre < ActiveRecord::Migration[7.0]
  def change
    change_column :offers, :genre, :integer, default: 0
    change_column :offers, :status, :integer, default: 0
  end
end
