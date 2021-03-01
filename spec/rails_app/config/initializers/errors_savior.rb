ErrorsSavior.configure do |config|
  # ErrorsSavior needs your api_origin metadata if you like to show this information on responses
  # config.api_origin = nil

  # Merge your own dicionary with ErrorsSavior dictionary
  config.external_dictionary_errors_path = 'config/locales/gems/errors_savior'
  config.locale = :en
end
