require 'rubygems'
require 'open-uri'
require 'nokogiri'
probrem_num = ARGV[0] || ""
if probrem_num !~ /\d?\d?\d/
  print "usage: ruby make_problem_text_for_num_.rb {Problem Number}\n"
  print "ex.  : ruby make_problem_text_for_num_.rb 12"
  exit
end

p filename = "%03d" % probrem_num + "/problem" + "%03d" % probrem_num + ".rb"
if File.exist?(filename)
  puts "File already exists."
  exit
end

doc = Nokogiri::HTML(open("http://odz.sakura.ne.jp/projecteuler/index.php?cmd=read&page=Problem%20" + probrem_num), nil, "utf-8")
doc.css("#body").each do |body|
  Dir.mkdir("%03d" % probrem_num)
  File.open(filename, "w") do |file|
    puts body.text
    file.write "#!/usr/bin/env ruby\n"
    file.write "# encoding : utf-8\n"
    file.write body.text.gsub(/^(.*)$/){"# " + $1}
  end
end

