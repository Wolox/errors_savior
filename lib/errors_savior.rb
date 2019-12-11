require 'errors_savior/version'
require 'errors_savior/config'
require 'errors_savior/saviors/record_invalid'
require 'active_support/all'

module ErrorsSavior
  extend ActiveSupport::Concern

  def self.configure
    yield Config
  end

  included do
    Saviors.constants.each do |const|
      savior = Saviors.const_get(const)
      next unless savior.is_a? Class

      rescue_from savior.error_class do |e|
        render json: savior.format(e), status: savior.status
      end
    end
  end
end
