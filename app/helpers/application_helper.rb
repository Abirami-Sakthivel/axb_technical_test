module ApplicationHelper

  def render_cached_json(cache_key, opts = {}, &block)
    opts[:expires_in] ||= 1.day

    expires_in opts[:expires_in], :public => true
    data = Rails.cache.fetch(cache_key, {raw: true}.merge(opts)) do
      block.call.to_json
    end
  end

  def active_class(path)
    return_class = ''
    if path.class == Array
      puts :true
      if path.any? { |str| request.path.include? str }
        return_class = 'active'
      end
    else
      if request.path.include?(path)
        puts :true
        return_class = 'active'
      end
      if  path=='pending_bills' and request.path == '/invoices/pending_bills'
        return_class = 'active'
      elsif  path=='collected_bills' and request.path == '/invoices/collected_bills'
        return_class = 'active'
      elsif
        (path=='pending_bills' ) and request.path == '/invoices'
        return_class = ''
      elsif
      (path=='invoices' )
        return_class = 'active'
      else
        (path=='collected_bills' ) and request.path == '/invoices'
        return_class = ''
      end
    end
    return_class
  end
end
