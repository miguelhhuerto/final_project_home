class AddNumberCountToItem < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :number_count, :integer, default: 0
  end
end
