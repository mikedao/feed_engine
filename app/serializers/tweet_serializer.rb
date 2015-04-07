class TweetSerializer < ActiveModel::Serializer
  attributes :id, :body, :username, :created_at, :updated_at,
             :user_profile_image, :latitude, :longitude, :article_id, :tweet_id
end
