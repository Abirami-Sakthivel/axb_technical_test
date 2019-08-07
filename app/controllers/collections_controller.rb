class CollectionsController < ApplicationController

  def create
    @invoice = Invoice.find(params[:invoice_id])
    collections = JSON.parse(File.read('public/helpers/collections.json'))
    collections.each_with_index  do |data, index|
      if @invoice.reference == data['reference']
        puts :index, index, :invoice_ref, @invoice.reference, :data_ref, data['reference']
        @invoice.collections.where(amount: data['amount'], reference: data['reference'], collection_date: data['collection_date']).first_or_create
      end
    end
    redirect_to invoices_path
  end
end