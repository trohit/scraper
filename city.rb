#!/usr/bin/ruby
## Simple script hack to scrape wallpapers.
def extractpage(out)
  urls = out.split("\n").select { |url| url.include?("img src") }.map  { |s| s.split('"')[1] }
  urls.each do |url|
    #puts "doing stuff on #{url}"
    #id = url.split("/").last
    id = url.split("//").last
    id.sub! 'i0.', 'https://'
    id.sub! 'i1.', 'https://'
    id.sub! 'i2.', 'https://'
    id.sub! 'i3.', 'https://'
    id.sub! 'i4.', 'https://'
    id.sub! 'i5.', 'https://'
    id.sub! 'i6.', 'https://'
    id.sub! 'i7.', 'https://'
    id.sub! 'i8.', 'https://'
    id.sub! "300x168", "1920x1080"
    id.sub! "300x188", "1920x1080"
    #puts "#{id}"
    if id.include? "wallpaperscraft"
      #filename = "#{id}.jpg"
      filename = "#{id}"
      puts "#{id}"
      if File.exists?(filename)
        puts "#{filename} exists. skipping"
        next
      end
      `wget #{filename}`
    end
    #`wget #{url} -O #{filename}`
  end
end

count = 31
cutoff = 49
prefix="curl -s https://wallpaperscraft.com/catalog/city"
while count < cutoff do
	if count != 1
        	cmd ="#{prefix}/page#{count}" 
	else
        	cmd ="#{prefix}"
	end	
	puts "#{cmd}"
	out = `#{cmd}`
	extractpage(out)
        count = count + 1
end
