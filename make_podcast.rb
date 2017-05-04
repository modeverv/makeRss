#!/usr/bin/env ruby
# frozen_string_literal:true

require 'time'
require 'nkf'

title = 'band-demo'
location = 'https://lovesaemi.daemon.asia/chiaki'

files = []

Dir.glob('/var/www/chiaki/demo/**/*.mp3') do |path|
  epath = File.expand_path(path)
  name = File.basename(path, File.extname(path))
  item = { 'path'   => epath,
           'name'   => name,
           'fname'  => epath, # File.basename(path),
           'time'   => File.ctime(path),
           'length' => File.size(path) }
  files << item
end

files = files.sort do |a, b|
  a['time'] <=> b['time']
end

puts <<~EOS
  <?xml version="1.0" encoding="utf-8"?>
  <rss xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" version="2.0">
    <channel>
      <title>#{title}</title>
EOS

files.each do |item|
  url = location + item['fname'].gsub('/demo', 'demo').gsub('var/www/chiaki', '')

  mime = if /\.mp3$/ =~ item['fname']
           'audio/mp3'
         else
           'audio/mp4'
         end

  puts <<-EOS
    <item>
      <title>#{item['name']}</title>
      <enclosure url="#{url}"
                 length="#{item['length']}"
                 type="#{mime}" />
      <guid isPermaLink="true">#{url}</guid>
      <pubDate>#{item['time'].rfc822}</pubDate>
    </item>
  EOS
end

puts <<~EOS
    </channel>
  </rss>
EOS
