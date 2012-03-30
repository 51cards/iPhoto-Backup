#!/usr/bin/env ruby

require 'fileutils'
require 'set'

class Image
  attr_reader :date, :path
  
  def initialize(date, path)
    @date = date.to_i
    @path = path
  end
  
  def <=>(x)
    x.date <=> @date
  end
  
  def fname()
    file = /[\w\.\s_\-\,\'\"]+$/.match(@path)
    "#{@date} #{file}"
  end
end

media = /
<key>DateAsTimerInterval<\/key>
<real>(.*)<\/real>
<key>ModDateAsTimerInterval<\/key>
<real>.*<\/real>
<key>MetaModDateAsTimerInterval<\/key>
<real>.*<\/real>
<key>ImagePath<\/key>
<string>(.*)<\/string>
/


destination = "."

if ARGV.length > 0
  destination = ARGV[0]
  abort "destination is invalid" unless File.directory?(destination)
end

libraryfile = File.expand_path("~") + "/Pictures/iPhoto\ Library/AlbumData.xml"
abort "unable to find iPhoto library" unless File.exists?(libraryfile)
library = File.open(libraryfile, "r").read

set = SortedSet.new()

library.scan(media).each do |path|
  set.add(Image.new(path[0], path[1]))
end

puts "library scanned, %i files found" % set.length

count = 0

set.each do |item|
  destfile = "#{destination}/#{item.fname}"
  unless File.exists?(destfile)
    begin
      print "copying #{item.fname}... "
      FileUtils.cp(item.path, destfile)
      puts "done"
      count += 1
    rescue Errno::ENOSPC
      FileUtils.rm(destfile)
      puts "failed, out of space\ncopied #{count} files"
      break
    end
  end
end
