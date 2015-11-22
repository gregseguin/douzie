class ChangeSayingFromStringToText < ActiveRecord::Migration
  def up
    change_column :jokes, :saying, :text
  end
  def down
    # This might cause trouble if you have strings longer
    # than 255 characters.
    change_column :jokes, :saying, :string
  end
end
