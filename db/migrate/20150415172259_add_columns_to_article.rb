class AddColumnsToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :byline, :string
    add_column :articles, :published_date, :date
    add_column :articles, :section, :string
    add_column :articles, :subsection, :string
  end
end
