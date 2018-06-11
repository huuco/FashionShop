class DeleteNameToWishlist < ActiveRecord::Migration[5.2]
  def change
    remove_column :wishlists, :name
  end
end
