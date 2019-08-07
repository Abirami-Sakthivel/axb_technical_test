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
      if path.any? { |str| request.path.include? str }
        return_class = 'active'
      end
    else
      if request.path.include?(path)
        return_class = 'active'
      end
    end
    return_class
  end
end
