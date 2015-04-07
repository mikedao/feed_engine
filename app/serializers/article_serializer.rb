class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :url, :desc_facet, :geo_facet, :abstract, :latitude, :longitude
  has_many :tweets

  def tweets
    object.tweets.pluck(:id)
  end
end
