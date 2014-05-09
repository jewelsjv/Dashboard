require 'twitter'


#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = 'tu9ppAx6KKm0LJVD7bT1KA'
  config.consumer_secret = ENV['CONSUMER_SECRET']
  config.access_token = '14924763-jhScTUo31YVtNbBpTZvyl9DrZbL5jWn947vUB822V'
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end

search_term = URI::encode('#code')

SCHEDULER.every '10m', :first_in => 0 do |job|
  begin
    tweets = twitter.search("#{search_term}")

    if tweets
      tweets = tweets.map do |tweet|
        { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_url_https}
        
      end
      send_event('twitter_mentions', comments: tweets)
    end
  rescue Twitter::Error
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
  end
end