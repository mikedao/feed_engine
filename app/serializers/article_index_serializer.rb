class ArticleIndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :url, :desc_facet, :geo_facet, :abstract, :latitude, :longitude
end
