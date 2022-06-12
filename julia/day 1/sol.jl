getIncreases(veccy::Vector{Int64}) = length([true for i in 1:(length(veccy) - 1) if veccy[i]<veccy[i+1]])

getSumIncreases(veccy::Vector{Int64}) = length([true for i in 1:(length(veccy) - 3) if veccy[i]<veccy[i+3]])

readlines64(path::String) = [parse(Int64, str) for str in readlines(path)]

function main()
	lines = readlines64("firstProblemNumbers.txt")
	# first part
	println("Answer for first part is $(getIncreases(lines))")

	# second part -- notice that a window is larger than the previous if and only if the first value of 
	# the previous window is smaller than the last value of the next window. This is true when 
	# a[i+3]>a[i] for some i and vector a
	println("Answer for first part is $(getSumIncreases(lines))")
end

main()
