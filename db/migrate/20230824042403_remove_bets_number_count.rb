class RemoveBetsNumberCount < ActiveRecord::Migration[7.0]
  def change
    remove_column :bets, :number_count
  end
end
