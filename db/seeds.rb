i = 0
while i < 100 do
  post = FactoryGirl.create(:post)
  post.save!
  i = i + 1
end
puts 'Created all of the posts'
