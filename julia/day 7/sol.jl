using StatsBase

readInput(path::String) = sort([parse(Int64, val) for val in split(readlines(path)[1],",")])

dist(val1::Int64, val2::Int64) = abs(val1 - val2)

specSum(num::Int64) = Int64((num+1)*(num/2))

function updateDists(veccy::Vector{Int64}, idx1::Int64)
	val1, val2 = veccy[idx1], veccy[idx1+1]
	for id in 1:length(veccy) if id <= idx1 veccy[id] += (val2 - val1) else veccy[id] -= (val2 - val1) end end
	return veccy
end

function firstPart(sortedVals::Vector{Int64})
	firstVal = sortedVals[1]
	currVal, currDists = firstVal, [val-firstVal for val in sortedVals]
	currFuel = sum([abs(dist) for dist in currDists])
	for idx in 1:(length(sortedVals)-1)
		nextDists = updateDists(currDists, idx)
		nextFuel = sum([abs(val) for val in nextDists])
		if nextFuel > currFuel return currFuel end
		currFuel = nextFuel
	end
end

function secondPart(sortedVals::Vector{Int64})
	firstVal = sortedVals[1]
	currVal, currDists = firstVal, [val-firstVal for val in sortedVals]
	currFuel = sum([specSum(abs(dist)) for dist in currDists])
	for idx in 1:(length(sortedVals)-1)
		nextDists = updateDists(currDists, idx)
		nextFuel = sum([specSum(abs(val)) for val in nextDists])
		if nextFuel > currFuel return currFuel end
		currFuel = nextFuel
	end	
end

function main()
	inp = readInput("seventhDayInput.txt")

	# First part
	println("Answer for first part $(firstPart(inp))")

	# Second part
	println("Answer for second part $(secondPart(inp))")

end

main()