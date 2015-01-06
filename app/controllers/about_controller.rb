class AboutController < ApplicationController

  before_action { title "About" }
  before_action { @nav = true }

  def index
  end

  def faq
  end

  def contact
  end

  def stockists
  end
end
