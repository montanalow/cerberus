
require 'time'

unicorn_cpu = `ps -o cputime -C unicorn_rails`.split("\n")[1..-1].inject(0){|sum,i| sum + ((Time.parse i) - (Time.parse '00:00:00')).to_i}
unicorn_rss = `ps -o rss -C unicorn_rails`.split("\n")[1..-1].inject(0){|sum,i| sum + i.to_i}
unicorn_vsize = `ps -o vsize -C unicorn_rails`.split("\n")[1..-1].inject(0){|sum,i| sum + i.to_i}

nginx_cpu = `ps -o cputime -C nginx`.split("\n")[1..-1].inject(0){|sum,i| sum + ((Time.parse i) - (Time.parse '00:00:00')).to_i}
nginx_rss = `ps -o rss -C nginx`.split("\n")[1..-1].inject(0){|sum,i| sum + i.to_i}
nginx_vsize = `ps -o vsize -C nginx`.split("\n")[1..-1].inject(0){|sum,i| sum + i.to_i}

apache_cpu = `ps -o cputime -C apache2`.split("\n")[1..-1].inject(0){|sum,i| sum + ((Time.parse i) - (Time.parse '00:00:00')).to_i}
apache_rss = `ps -o rss -C apache2`.split("\n")[1..-1].inject(0){|sum,i| sum + i.to_i}
apache_vsize = `ps -o vsize -C apache2`.split("\n")[1..-1].inject(0){|sum,i| sum + i.to_i}

passenger_cpu = `ps -eo cputime,cmd | grep  "[P]assenger"`.split("\n").map{|r| r.split(/\s/)[0] }.inject(0){|sum,i| sum + ((Time.parse i) - (Time.parse '00:00:00')).to_i}
passenger_rss = `ps -eo rss,cmd | grep  "[P]assenger"`.split("\n").map{|r| r.split(/\s/)[0] }.inject(0){|sum,i| sum + i.to_i}
passenger_vsize = `ps -eo vsize,cmd | grep  "[P]assenger"`.split("\n").map{|r| r.split(/\s/)[0] }.inject(0){|sum,i| sum + i.to_i}


rails_cpu = `ps -eo cputime,cmd | grep  "[R]ails"`.split("\n").map{|r| r.split(/\s/)[0] }.inject(0){|sum,i| sum + ((Time.parse i) - (Time.parse '00:00:00')).to_i}
rails_rss = `ps -eo rss,cmd | grep  "[R]ails"`.split("\n").map{|r| r.split(/\s/)[0] }.inject(0){|sum,i| sum + i.to_i}
rails_vsize = `ps -eo vsize,cmd | grep  "[R]ails"`.split("\n").map{|r| r.split(/\s/)[0] }.inject(0){|sum,i| sum + i.to_i}

puts "#{nginx_cpu + unicorn_cpu}\t#{nginx_rss + unicorn_rss}\t#{nginx_vsize + unicorn_vsize}"
puts "#{apache_cpu + passenger_cpu + rails_cpu}\t#{apache_rss + passenger_rss + rails_rss}\t#{apache_vsize + passenger_vsize + rails_vsize}"


