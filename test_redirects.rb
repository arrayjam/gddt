require "open-uri"

canonical = "http://www.dogdaytraining.com.au/"

redirects = [
  "http://dogdaytraining.com.au/",
  "http://gooddogdaytraining.com.au/",
  "http://www.gooddogdaytraining.com.au/",
  "http://gooddogdaytraining.com/",
  "http://www.gooddogdaytraining.com/"
]

failed = 0

redirects.each do |url|
  begin
    open(URI.parse(url)) do |page|
      abort if page.base_uri.to_s != canonical
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
