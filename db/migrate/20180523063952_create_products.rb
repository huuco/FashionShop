class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.float :old_price
      t.float :price
      t.float :discount
      t.integer :quantity
      t.text :short_description
      t.text :long_description
      t.string :tag
      t.string :ref
      t.integer :brand_id
      t.integer :category_id
      t.boolean :active, default: false
      t.boolean :deleted, default: 0
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
