class CreateCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :collections do |t|
      t.float :amount
      t.string :reference, default: ""
      t.date :collection_date
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
