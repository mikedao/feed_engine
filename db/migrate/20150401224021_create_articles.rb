class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :url
      t.string :desc_facet
      t.string :abstract
      t.string :geo_facet

      t.timestamps null: false
    end
  end
end
