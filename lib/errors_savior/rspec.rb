RSpec::Matchers.define :be_rescuted_by_savior do
  match do |response|
    @response_body = response_body
    return false unless exists_savior?
    error_detail[:http_status_code] == response.status &&
    match_with_dictionary(%i[error_code message])
  end

  def exists_savior?
    error_code = @response_body['error_code']
    return false if error_code.nil?

    @savior = ErrorsSavior::Dictionary::LocalDictionary.find_savior_by_error_code(error_code)
    @savior.present?
  end

  def error_detail
    @error_detail ||= ErrorsSavior::Dictionary::LocalDictionary
                      .errors_dictionary[@savior.keys.first]
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
