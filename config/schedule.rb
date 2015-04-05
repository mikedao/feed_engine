set :environment, "development"
set :output, error: "log/cron_error_log.log", standard: "log/cron_log.log"

every 30.minutes do
  runner "NytimesService.new.articles"
  runner "Article.build_associated_tweets"
end


