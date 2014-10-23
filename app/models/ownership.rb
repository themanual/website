class Ownership < ActiveRecord::Base
  belongs_to :user
  belongs_to :issue
  belongs_to :subscription

  # LEVELS
  #
  # WEB   - web only
  # EBOOK - ebook & web
  # AUDIO - audio, ebook & web
  # PRINT - print, ebook & web
  # FULL  - print, audio, ebook & web

  def level_types
    @level_types ||= case level
    when 'web'
      [:web]
    when 'ebook'
      [:web, :ebook]
    when 'audio'
      [:web, :ebook, :audiobook]
    when 'print'
      [:web, :ebook, :print]
    when 'full'
      [:web, :ebook, :audiobook, :print]
    end
  end

  def can_access? type # audiobook, ebook, web
    level_types.include? type.to_sym
  end
end
