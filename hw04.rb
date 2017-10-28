# Create a program that can read a file named "dates.txt". The file will
# contain a list of dates in the format of "MON DAY, YEAR" for example
# "Jan 1, 1970". MON will always be three characters. However, it could be
# uppercase, lowercase, or mixed case. Some of the dates may be invalid. Your
# program should recognize this and just skip the date. You might want to use
# your SimpleDate file from the previous homework. As you parse each date, you
# should write the date to a new file named "hex-dates.txt". It should be
# formatted as follows "0xHEX_YEAR 0xHEX_MONTH 0xHEX_DAY".

# A sample "dates.txt" has been provided for you, but this is not the file that
# your homework will be tested against. You should find more edge cases, or just
# ask for the final files I will be using to grade your assignments.

firstFile = File.open("dates.txt").each do |line|
	line = line.split(" ")
	line[1] = line[1].chomp(",")

	if line[0].casecmp("JAN") == 0
	    line[0] = "0x1"
	elsif line[0].casecmp("FEB") == 0
		line[0] = "0x2"
	elsif line[0].casecmp("MAR") == 0
		line[0] = "0x3"
	elsif line[0].casecmp("APR") == 0
		line[0] = "0x4"
	elsif line[0].casecmp("MAY") == 0
		line[0] = "0x5"
	elsif line[0].casecmp("JUN") == 0
		line[0] = "0x6"
	elsif line[0].casecmp("JUL") == 0
		line[0] = "0x7"
	elsif line[0].casecmp("AUG") == 0
		line[0] = "0x8"
	elsif line[0].casecmp("SEP") == 0
		line[0] = "0x9"
	elsif line[0].casecmp("OCT") == 0
		line[0] = "0xA"
	elsif line[0].casecmp("NOV") == 0
		line[0] = "0xB"
	elsif line[0].casecmp("DEC") == 0
		line[0] = "0xC"
	else
		next
	end
	# puts line[0]

	# returns 'true' if current year is a leap year
  	# Source: https://codereview.stackexchange.com/questions/23902/leap-year-algorithm
	def is_leap?(year)
    	return (year % 400 == 0) || (year % 100 != 0 && year % 4 == 0)
  	end

	year = line[2].to_i

	if line[0] == "0x2" && is_leap?(year) && line[1].to_i > 29
		next
	elsif line[0] == "0x2" && !(is_leap?(year)) && line[1].to_i > 28
		next
	elsif (line[0] == "0x1" || line[0] == "0x3" || line[0] == "0x5" || line[0] == "0x7" ||
		  line[0] == "0x8" || line[0] == "0xA" || line[0] == "0xC") && line[1].to_i > 31
		next
	elsif (line[0] == "0x4" || line[0] == "0x6" || line[0] == "0x9" || line[0] == "0xB") &&
		line[1].to_i > 30
		next
	elsif line[1].to_i < 1
		next
	elsif line[1].to_i > 0 && line[1].to_i < 32
		line[1] = line[1].to_i
		line[1]	= "0x" + line[1].to_s(16).upcase
	else
		next
	end
	#puts line[1]

	if line[2].to_i > 1000 && line[2].to_i < 2031
		line[2] = line[2].to_i
		line[2] = "0x" + line[2].to_s(16).upcase
	else
		next
	end
	#puts line[2]

	answer = line[2] + " " + line[0] + " " + line[1] + "\n"

	outputFile = "hex-dates.txt"
	openOutputFile = open(outputFile, 'a')
	openOutputFile.write(answer)
	openOutputFile.close

	end

File.truncate("hex-dates.txt", File.size("hex-dates.txt") - 2)

# Test: Compares output file to hex-dates2.txt

# hex1 = "hex-dates.txt"
# hex2 = "hex-dates2.txt"

# openHex1 = open(hex1)
# openHex2 = open(hex2)

# readHex1 = openHex1.read
# readHex2 = openHex2.read

# if readHex1 == readHex2
# 	puts "equal"
# else
# 	puts "not equal"
# end
