require 'errors_savior/version'
require 'errors_savior/config'
require 'active_support/all'

require 'errors_savior/dictionary/local_dictionary'

require 'errors_savior/protocol/render_error'

require 'errors_savior/saviors/base_savior'
require 'errors_savior/saviors/not_unique'
require 'errors_savior/saviors/parameter_missing'

module ErrorsSavior
  extend ActiveSupport::Concern

  def self.configure
    yield Config
  end

  included do
    Saviors.constants.each do |const|
      savior = Saviors.const_get(const)
      next if savior == ErrorsSavior::Saviors::BaseSavior || !savior.is_a?(Class)

      rescue_from savior.error_class do |error|
        Rails.logger.error(savior.savior_attributes)
        protocol = ErrorsSavior::Protocol::RenderError.new(savior, error)
        render json: protocol.as_json, status: savior.http_status_sym
      end
    end
  end
end
