class Api::V1::TweetsController < ApplicationController
  respond_to :json, :xml

  def index
    BuildTweetsJob.new.perform("event")
  end
end
