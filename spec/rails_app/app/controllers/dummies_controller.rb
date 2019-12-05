class DummiesController < ApplicationController
  def create
    Dummy.create!
    head :ok
  end
end
