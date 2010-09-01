
Author.blueprint do
  name { Faker::Name.name }
end

Publisher.blueprint do
  name { Faker::Company.name }
end

Book.blueprint do
  title { Faker::Company.catch_phrase }
  isbn { (0..10).map {|n| rand(10).to_s }.join }
  authors { (0..(rand(2)+1)).map { |n| Author.make! } }
  publisher { Publisher.make! }
end
