require 'redis-rails'
class Invoice < ApplicationRecord
  has_many :collections

  # after_save :write_cache

  validates_uniqueness_of :reference


  # def write_cache
  #   unless Rails.cache.fetch('invoices_list').blank?
  #     json = JSON.parse(Rails.cache.fetch('invoices_list')).map { |k, str|  k and k['reference'] == self.reference  ? k = JSON.parse(self.to_json) : k}.to_json
  #     JSON.parse(Rails.cache.write('invoices_list', json))
  #   end
  #
  # end

  # def clear_cache
  #   Rails.cache.redis.del('invoices_list')
  # end
end
