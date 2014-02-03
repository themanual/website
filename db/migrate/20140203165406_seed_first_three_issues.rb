class SeedFirstThreeIssues < ActiveRecord::Migration
  def up

    legacy = HashWithIndifferentAccess.new(YAML.load(IO.read(File.join(Rails.root, "legacy", "issues.yml"))))

  	v = Volume.create number: 1

  	[1,2,3].each do |i|
  		issue = v.issues.create number: i

  		data = legacy[:issue][i]

      position = 1

  		data.keys.each do |key|
  			a = Author.create slug: key, name: data[key][:author], bio: data[key][:bio]

  			issue.articles.create	author_id: a.id,
  														title: data[key][:article][:title],
  														synopsis: data[key][:article][:synopsis],
  														illustrator: data[key][:article][:illustrator],
  														body: File.read(Rails.root.join('legacy','pieces',"issue-#{i}","#{key}-article.md")),
                              position: position

  			issue.lessons.create	author_id: a.id,
  														title: data[key][:lesson][:title],
  														synopsis: data[key][:lesson][:synopsis],
  														body: File.read(Rails.root.join('legacy','pieces',"issue-#{i}","#{key}-lesson.md")),
                              position: position

        position += 1

  		end
  	end


  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
