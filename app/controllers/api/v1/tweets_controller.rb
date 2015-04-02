class Api::V1::TweetsController < ApplicationController
  respond_to :json, :xml

  def index
    TwitterFeed.new.sample
  end
end
