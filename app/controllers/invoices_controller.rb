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

  def pending_bills


    pending_bills = []
    Invoice.joins(:collections).each do |invoice|
      if !invoice.blank? and !invoice.collections.blank?
        # puts :ref, invoice.reference, :amt, invoice.amount + invoice.collections.load.last.amount
        if invoice.amount.to_i + invoice.collections.load.last.amount.to_i == 0.0
          pending_bills << invoice
        end
      end
    end
    @invoices = render_cached_json("pending_list", {expires_in: 5.minutes}) do
      pending_bills
    end
    @invoices = JSON.parse(@invoices, object_class: Invoice)
  end

  def collected_bills
    collected_bills = []
    Invoice.joins(:collections).each do |invoice|
      if !invoice.blank? and !invoice.collections.blank?
        if invoice.amount.to_i + invoice.collections.load.last.amount.to_i != 0.0
          collected_bills << invoice
        end
      end
    end
    @invoices = render_cached_json("collected_bill_list", {expires_in: 5.minutes}) do
      collected_bills
    end
    @invoices = JSON.parse(@invoices, object_class: Invoice)
  end

end