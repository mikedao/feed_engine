require 'matrix'
require 'tf-idf-similarity'

class KeywordEngine
  KEYWORDS_PER_ARTICLE = 4
  MINIMUM_KEYWORD_LENGTH = 4

  attr_reader :corpus,
              :model

  def initialize
    @corpus = create_corpus
    @model = create_model
  end

  def create_corpus
    Article.all.map do |article|
      base_text = article.keyword_base_text
      TfIdfSimilarity::Document.new(base_text)
    end
  end

  def create_model
    TfIdfSimilarity::TfIdfModel.new(corpus)
  end

  def generate_keywords(article)
    tfidf_by_term = {}
    document = find_document(article)
    document.terms.each do |term|
      tfidf_by_term[term] = model.tfidf(document, term)
    end
    sorted_keywords = tfidf_by_term.sort_by{|_,tfidf| -tfidf}
    sorted_keywords.map do |element|
      element[0]
    end.reject do |word|
      word.length < MINIMUM_KEYWORD_LENGTH
    end[0..KEYWORDS_PER_ARTICLE].join(",")
  end

  private

  def find_document(article)
    corpus.find { |document| document.text == article.keyword_base_text}
  end
end
