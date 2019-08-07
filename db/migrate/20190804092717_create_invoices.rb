class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.string :reference, default: ""
      t.float :amount
      t.date :invoice_date
      t.string :brand_manager, default: ""
      t.text :narration
      t.string :customer_name



      t.timestamps
    end
  end
end
