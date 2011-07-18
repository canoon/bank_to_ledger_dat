#!/usr/bin/ruby

account = ARGV[0]

def trimq(x) 
	return x.gsub(/"/,'')
end

def revdate(x) 
	return x.split("/").reverse.join("/")
end

STDIN.each_line{ |line|
	arr = line.split ','
	if (arr.length == 4) then
        	puts "#{revdate(arr[0])} #{trimq(arr[2])}"
	        puts "    #{account} 		$#{trimq(arr[1]).gsub(/\+/,'')}"
        	puts ""
	end
}
