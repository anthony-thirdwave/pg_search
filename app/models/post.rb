class Post < ActiveRecord::Base
  include PgSearch
  multisearchable against: [:title, :body]
end


# To use search, simply type results = Post.custom_search("foo") and
# it will populate and array of objects that match your search.
