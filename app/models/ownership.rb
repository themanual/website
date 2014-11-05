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

  LEVELS = {
    'web' => {
      includes: [:web],
      description: 'Web Subscription'
    },
    'ebook' => {
      includes: [:web, :ebook],
      description: 'Ebook Subscription'
    },
    'audio' => {
      includes: [:web, :ebook, :audiobook],
      description: 'Audio Subscription'
    },
    'print' => {
      includes: [:web, :ebook, :print],
      description: 'Print & Ebook Subscription'
    },
    'full' => {
      includes: [:web, :ebook, :audiobook, :print],
      description: 'Print, Ebook & Audio Subscription'
    },

  }

  def level_types
    @level_types ||= LEVELS[level][:includes]
  end

  def can_access? type # audiobook, ebook, web
    level_types.include? type.to_sym
  end

  def shipped!
    update_attribute :shipped, true
  end
end
