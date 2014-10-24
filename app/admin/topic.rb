ActiveAdmin.register ActsAsTaggableOn::Tag, as: 'Topic' do

  menu parent: 'Editorial'

  permit_params :name, :bio, :slug, :twitter

  filter :name

  index do
    column :name
    column :taggings_count, label: 'Count'
    column :enabled
    actions defaults: false do |topic|
      if topic.enabled?
        link_to('Disable', disable_admin_topic_path(topic))
      else
        link_to('Enable', enable_admin_topic_path(topic))
      end
    end
  end

  member_action :enable, :method => :get do
    ActsAsTaggableOn::Tag.find(params[:id]).update_attribute :enabled, true
    Piece.active_topics_cache_clear
    redirect_to admin_topics_path, notice: "Emnabled Topic!"
  end

  member_action :disable, :method => :get do
    ActsAsTaggableOn::Tag.find(params[:id]).update_attribute :enabled, false
    Piece.active_topics_cache_clear
    redirect_to admin_topics_path, notice:"Disabled Topic!"
  end
end
