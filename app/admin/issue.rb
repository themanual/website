ActiveAdmin.register Issue do

  permit_params :number

  filter :authors
  filter :volume

  index do
  	id_column
  	column :number
  	default_actions
  end


  sidebar :articles , :only => :show do
    table_for issue.articles do
      column :author do |article|
        link_to(article.author.name, admin_author_path(article.author))
      end
      column :name do |article|
        link_to(article.title, admin_piece_path(article))
      end
    end
  end

  sidebar :lessons , :only => :show do
    table_for issue.lessons do
      column :lesson do |article|
        link_to("by #{article.author.name}", admin_piece_path(article))
      end
    end

  end

end
