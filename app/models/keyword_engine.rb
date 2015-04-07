require "matrix"
require "tf-idf-similarity"

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
    sort_and_filter_terms(tfidf_by_term)
  end

  private

  def find_document(article)
    corpus.detect { |document| document.text == article.keyword_base_text }
  end

  def sort_and_filter_terms(tfidf_by_term)
    sorted_keywords = sort_terms(tfidf_by_term)
    filter_terms(sorted_keywords)
  end

  def sort_terms(tfidf_by_term)
    tfidf_by_term.sort_by { |_, tfidf| -tfidf }
  end

  def filter_terms(sorted_keywords)
    terms = sorted_keywords.map do |element|
      element[0]
    end
    filtered_terms = terms.reject do |term|
      term.length < MINIMUM_KEYWORD_LENGTH
    end
    filtered_terms[0..KEYWORDS_PER_ARTICLE].join(",")
  end
end
