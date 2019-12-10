require 'errors_savior/version'
require 'errors_savior/config'
require 'active_support/all'

Dir[File.dirname(__FILE__) + '/errors_savior/**/*.rb'].each { |file| require file }

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
