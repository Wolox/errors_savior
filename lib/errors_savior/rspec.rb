RSpec::Matchers.define :be_rescuted_by do
  match do |response|
    @response_body = response_body
    error_detail[:http_status_code] == response.status &&
    match_with_dictionary(%i[error_code message])
  end

  chain :savior do |savior_class_name|
    @error_class_name = "ErrorsSavior::Saviors::#{savior_class_name}".constantize.error_class_name
  end

  def error_detail
    @error_detail ||= ErrorsSavior::Dictionary::LocalDictionary
                      .errors_dictionary[@error_class_name]
  end

  def match_with_dictionary(attributes)
    attributes.all? do |attribute|
      @response_body[attribute.to_s] == error_detail[attribute]
    end
  end

  failure_message do |response_body|
    'expected response does not behave like a savior'
  end
end
