class CreateJokes < ActiveRecord::Migration
  def change
    create_table :jokes do |t|
      
      t.string :title
      t.string :saying
      t.string :author

      t.timestamps
    end
  end
end
