class Kickstarter
  
  URL = 'https://www.kickstarter.com/projects/goodonpaper/the-manual-everywhere'
  
  def self.fetch_stats
    puts "Fetching Kickstarter stats..."
    doc = Nokogiri::HTML(open(URL))
    data = {}
    data[:deadline]   = doc.css('#project_duration_data').first['data-end_time'].to_datetime
    data[:backers]    = doc.css('#backers_count').first['data-backers-count'].to_i
    pledged           = doc.css('#pledged').first
    data[:pledged]    = pledged['data-pledged'].to_i
    data[:goal]       = pledged['data-goal'].to_i
    data[:percent]    = data[:pledged] * 1.0 / data[:goal]
    data[:curency]    = doc.css('#pledged data').first['data-currency']
    data
  end

  def self.stats
    Rails.cache.fetch('kickstarter:stats', expires_in: 1.hour) do
      self.fetch_stats
    end
  end
  
end