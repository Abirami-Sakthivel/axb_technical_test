class Invoice < ApplicationRecord
  has_many :collections

  after_save :write_cache


  def write_cache
    json = JSON.parse(Rails.cache.fetch('invoices_list')).map { |k, str|  k and k['reference'] == self.reference  ? k = JSON.parse(self.to_json) : k}.to_json
    JSON.parse(Rails.cache.write('invoices_list', json))
  end
end
