class InvoicesController < ApplicationController
include ApplicationHelper
  def index
    invoices_collection = JSON.parse(File.read('public/helpers/new_invoices.json'))
   if Invoice.includes(:collections).blank?
     invoices_collection.each do |data|
       Invoice.where(brand_manager: data['brand_manager'], customer_name: data['customer_name'], narration: data['narration'], amount: data['amount'], reference: data['reference'], invoice_date: data['invoice_date']).first_or_create
     end
   end
    @invoices = render_cached_json("invoices_list", {expires_in: 1.hour}) do
      Invoice.includes(:collections)
    end
    @invoices = JSON.parse(@invoices, object_class: Invoice)
  end

end