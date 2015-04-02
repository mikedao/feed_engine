class Api::V1::TweetsController < ApplicationController
  respond_to :json, :xml

  def index
    TweetJob.new.async.perform("event")
  end
end
