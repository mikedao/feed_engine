class ArticleSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :url,
             :desc_facet,
             :geo_facet,
             :abstract,
             :latitude,
             :longitude,
             :links

  has_many :tweets

  def tweets
    object.tweets.pluck(:id)
  end

  def links
    { tweets: "/articles/#{object.id}/tweets" }
  end
end
