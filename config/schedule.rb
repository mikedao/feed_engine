every 5.minutes do
  runner "NytimesService.new.articles"
  command "echo 'you can use raw cron sytax too'"
end
