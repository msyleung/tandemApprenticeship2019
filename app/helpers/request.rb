module RequestHelper
  def pretty_response(link, data)
    request.accept.each do |type|
      case type.to_s
      when 'text/html'
        halt erb link
      when 'text/json'
        halt data.to_json
      end
    end
    error 406
  end
end
