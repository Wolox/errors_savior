module Response
  module JSONParser
    def response_body
      ActiveSupport::JSON.decode(response.body) if response&.body&.present?
    end
  end
end
