class ApplicationController < ActionController::API
  include ErrorsSavior

  include ErrorsSavior::Saviors::MySaviors
end
