Recipe.all.each do |r|
  unless r.name
    r.parse
    r.save
  end
end