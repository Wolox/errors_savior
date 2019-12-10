module ErrorsSavior
  module Protocol
    class RenderError
      def initialize(savior, error)
        @savior = savior
        @error = error
      end

      def render_errors
        Rails.logger.error(@savior)
        render json: as_json, status: @savior.http_status_sym
      end

      def as_json
        json = required_error_body
        json['errors'] = errors.as_json if errors.present?

        @consider_all_requests_local ? append_meatadata(json) : json
      end

      def required_error_body
        {
          error_code: @savior.error_code,
          message: @savior.message,
          timestamp: Time.zone.now
        }
      end

      def append_metadata(json)
        json['metadata']['error_class'] = @savior.error_class
        # TODO: json['metadata']['api_origin'] = ErrorsSavior.config.api_origin.enabled?
        json['metadata']['stack_trace'] = @error.backtrace

        json
      end
    end
  end
end
