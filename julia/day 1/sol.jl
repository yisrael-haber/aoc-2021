function getIncreases(veccy::Vector{Int64})
	return length([true for i in 1:(length(veccy) - 1) if veccy[i]<veccy[i+1]])
end

function getSumIncreases(veccy::Vector{Int64})
	return length([true for i in 1:(length(veccy) - 3) if veccy[i]<veccy[i+3]])
end

function readlines64(path::String)
	lines = readlines(path)
	return [parse(Int64, str) for str in lines]
end

function main()
	# first part
	lines = readlines64("firstProblemNumbers.txt")
	# println("Answer for first part is $(getIncreases(lines))")

	# second part -- notice that a window is larger than the previous if and only if the first value of 
	# the previous window is smaller than the last value of the next window. This is true when 
	# a[i+3]>a[i] for some i and vector a
	println("Answer for first part is $(getSumIncreases(lines))")

end

main()