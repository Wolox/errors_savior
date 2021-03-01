module ErrorsSavior
  module Protocol
    class RenderError
      def initialize(savior, error)
        @savior = savior
        @error = error
      end

      def as_json
        json = required_error_body
        json['errors'] = @savior.errors(@error).as_json if @savior.respond_to?(:errors)

        Rails.configuration.consider_all_requests_local ? append_metadata(json) : json
      end

      def required_error_body
        {
          error_code: @savior.error_code,
          message: @savior.message,
          timestamp: Time.zone.now
        }
      end

      def append_metadata(json)
        json['metadata'] = {}
        json['metadata']['error_class'] = @savior.error_class.name
        json['metadata']['api_origin'] = Config.api_origin if Config.api_origin.present?
        json['metadata']['stack_trace'] = @error.backtrace

        json
      end
    end
  end
end
