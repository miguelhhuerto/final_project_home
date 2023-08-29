class CreateNewsTickers < ActiveRecord::Migration[7.0]
  def change
    create_table :news_tickers do |t|
      t.string :content
      t.integer :status, default: 0
      t.string :admin_id
      t.timestamps
    end
  end
end
