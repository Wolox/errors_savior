module ErrorsSavior
  module ConfigHelper
    module_function

    def reset!
      ErrorsSavior::Config::DEFAULT_CONFIG.each do |k, v|
        ErrorsSavior::Config.send("#{k}=", v)
      end
    end
  end
end
