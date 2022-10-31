class AddItemsToSupermarkets < ActiveRecord::Migration[5.2]
  def change
    add_reference :supermarkets, :item, foreign_key: true
  end
end
