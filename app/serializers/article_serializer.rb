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

  def links
    { tweets: "/api/v1/articles/#{object.id}/tweets" }
  end
end
