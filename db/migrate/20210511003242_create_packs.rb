class CreatePacks < ActiveRecord::Migration[6.1]
  def change
    create_table :packs do |t|
      t.integer :quantity
      t.decimal :price
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
