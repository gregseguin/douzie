class CreateFavoriteJokes < ActiveRecord::Migration
  def change
    create_table :favorite_jokes do |t|
      t.integer :joke_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
