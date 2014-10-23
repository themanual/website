ActiveAdmin.register Issue do

  permit_params :number, :published_on, :volume_id, :portrait_illustrator

  filter :authors
  filter :volume

  index do
  	id_column
  	column :number
  	actions
  end

  sidebar :downloads , :only => :show do
    table_for issue.downloads.order('medium asc, ordering asc') do
      column :medium
      column :format do |d|
        link_to(d.format, admin_download_path(d))
      end
      column :size do |d|
        number_to_human_size d.file_file_size
      end
    end
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
