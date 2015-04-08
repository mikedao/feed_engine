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
    { tweets: "/articles/#{object.id}/tweets" }
  end
end
