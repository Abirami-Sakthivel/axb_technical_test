module ApplicationHelper

  def bootstrap_class_for flash_type
    {success: 'alert-success', error: 'alert-danger', alert: 'alert-warning', notice: 'alert-info'}[flash_type] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "text-center alert alert-dismissible fade show #{bootstrap_class_for(msg_type.to_sym)}") do
        concat content_tag(:button, 'x', class: 'close', data: {dismiss: 'alert'})
        concat simple_format(message)
      end)
    end
    nil
  end

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
      else
        (path=='collected_bills' or path == 'pending_bills') and request.path == '/invoices'
        return_class = ''
      end
    end
    return_class
  end

  def formatted_decimal(number)
    if number.blank?
      'N/A'
    else
      number_with_precision(number, precision: 2, delimiter: ',')
    end
  end

  def formatted_datetime(datetime)
    if datetime.blank?
      ''
    else
      datetime.strftime('%m/%d/%y')
    end
  end
end
