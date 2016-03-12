
# Ruby Lotto test!




def get_lotto
	picked_numbers = {}
	while picked_numbers.size < 7
		num = 1 + Random.rand(35)
		if (picked_numbers[num] == 1)
			#puts "Number #{num} already taken"
		else
			picked_numbers[num] = 1
			#puts "Selected #{num}"
		end
	end
	return picked_numbers
end

def num_correct(correct_row, my_row)
	n = 0
	#puts "Size of my_row is #{my_row.keys.size}"
	my_row.keys.each do |nn|
		if correct_row[nn] == 1
			n = n + 1
		end
	end
	return n
end


test_correct = {1=>1,2=>1,3=>1,4=>1,5=>1,6=>1,7=>1}
check = {1=>1,8=>1,9=>1,10=>1,11=>1,12=>1,13=>1}
puts "Result should be 1: #{num_correct(test_correct, check)}"




corr = get_lotto


max_correct = 0
1000000.times {
	my_row = get_lotto
	#puts "Correct numbers are #{num_correct(corr, my_row)}"

	correct = num_correct(corr, my_row)
	if (correct > max_correct)
		max_correct = correct
	end
}

puts "Best guess was: #{max_correct} !"
puts "Correct numbers were:"
corr.keys.each do |i|
	puts "#{i}"
end



