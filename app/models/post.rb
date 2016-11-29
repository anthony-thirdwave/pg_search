class Post < ActiveRecord::Base
  include PgSearch
  pg_search_scope :custom_search,
    :against => {
      :title => 'A',
      :body => 'B'
    },
    :using => {
      :tsearch => {:prefix => true}
    }
end


# To use search, simply type results = Post.custom_search("foo") and
# it will populate and array of objects that match your search. 
