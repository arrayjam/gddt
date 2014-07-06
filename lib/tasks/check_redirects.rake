task :check_redirects do
  require "open-uri"

  canonical = "http://www.dogdaytraining.com.au/"

  redirects = [
    "http://dogdaytraining.com.au/",
    "http://gooddogdaytraining.com.au/",
    "http://www.gooddogdaytraining.com.au/",
    "http://gooddogdaytraining.com/",
    "http://www.gooddogdaytraining.com/",
    "http://hurp.com",
  ]

  failed = 0

  redirects.each do |url|
    begin
      open(URI.parse(url)) do |page|
	if page.base_uri.to_s != canonical
	  puts "#{url} points to #{page.base_uri.to_s}"
	  failed += 1
	end
      end
    rescue SocketError
      failed += 1
      puts "Failed to resolve #{url}"
    else
      next
    end
  end

  if failed == 0
    exit
  else
    abort "#{failed} failure#{failed > 1 ? 's' : ''}"
  end
end
