class DummiesController < ApplicationController
  def create
    Dummy.create!(create_params)
    head :ok
  end

  private

  def create_params
    required_params = %i[name number]
    params.require(required_params)
    params.permit(required_params)
  end
end
