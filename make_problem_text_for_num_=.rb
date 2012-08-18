require 'rubygems'
require 'open-uri'
require 'nokogiri'
# オイラーの問題を取得するように変更
probrem_num = ARGV[0] || "19"
exit if probrem_num == ""
p filename = "problem" + "%03d" % probrem_num + ".rb"
if File.exist?(filename)
  puts "exists file."
  exit
end

doc = Nokogiri::HTML(open("http://odz.sakura.ne.jp/projecteuler/index.php?cmd=read&page=Problem%20" + probrem_num), nil, "utf-8")
doc.css("#body").each do |body|
  File.open(filename, "w") do |file|
    puts body.text
    file.write body.text.gsub(/^(.*)$/){"# " + $1}
  end
end

