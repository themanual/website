

puts 'Importing legacy issues.'

legacy = HashWithIndifferentAccess.new(YAML.load(IO.read(File.join(Rails.root, "legacy", "issues.yml"))))

v = Volume.create number: 1

[1,2,3].each do |i|
  issue = v.issues.create number: i, public: true

  data = legacy[:issue][i]

  position = 1

  data.keys.each do |key|
    a = Author.create slug: key, name: data[key][:author], bio: data[key][:bio]

    issue.articles.create author_id: a.id,
                          title: data[key][:article][:title],
                          synopsis: data[key][:article][:synopsis],
                          illustrator: data[key][:article][:illustrator],
                          body: File.read(Rails.root.join('legacy','pieces',"issue-#{i}","#{key}-article.md")),
                          position: position

    issue.lessons.create  author_id: a.id,
                          title: data[key][:lesson][:title],
                          synopsis: data[key][:lesson][:synopsis],
                          body: File.read(Rails.root.join('legacy','pieces',"issue-#{i}","#{key}-lesson.md")),
                          position: position

    position += 1

  end
end

Issue.where(number: 1).update_all published_on: Date.new(2012,1,1)
Issue.where(number: 2).update_all published_on: Date.new(2012,5,1)
Issue.where(number: 3).update_all published_on: Date.new(2012,9,1)


puts 'Stubbing out future issues'

Issue.create number: 4, published_on: Date.new(2014,4,10)
Issue.create number: 5, published_on: Date.new(2014,8,10)
Issue.create number: 6, published_on: Date.new(2014,12,10)


puts 'Generating Shoppe products'

cat = Shoppe::ProductCategory.create name: 'The Manual', permalink: 'the-manual'

[1,2,3].each do |i|

  name = "Issue ##{i}"

  digital = Shoppe::Product.create sku: "ISSUE00#{i}DIG", name: "Issue ##{i} Digital", permalink: "issue-#{i}-digital", description: name, short_description: name, product_category_id: cat.id, stock_control: false, price: 10, product_attributes_array: [{'key' => :issue_number, 'value' => i, 'searchable' => 1, 'public' => 1},{'key' => :format, 'value' => :digital, 'searchable' => 1, 'public' => 1}]

  print = Shoppe::Product.create sku: "ISSUE00#{i}PRN", name: "Issue ##{i} Print", permalink: "issue-#{i}-print", description: name, short_description: name, product_category_id: cat.id, stock_control: false, price: 25, product_attributes_array: [{'key' => :issue_number, 'value' => i, 'searchable' => 1, 'public' => 1},{'key' => :format, 'value' => :print, 'searchable' => 1, 'public' => 1}]

end

User.create email: 'marc@neutroncreations.com', password: SecureRandom.hex, access_level: 2
