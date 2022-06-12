using StatsBase

dictSum(dictToSum::Dict{Int64, Int64}) = sum([val for (key,val) in dictToSum])

readInput(path::String) = [parse(Int64, val) for val in split(readlines(path)[1],",")]

function operation(veccy::Vector{Int64})
	dictMap, toSend = countmap(veccy), Vector{Int64}[]
	for (key, val) in dictMap
		if key == 0 toSend = vcat(toSend, [6 for i in 1:val], [8 for i in 1:val]) end
		if key != 0 toSend = vcat(toSend, [key - 1 for i in 1:val]) end
	end
	return toSend
end


function partOne(veccy::Vector{Int64}, days::Int64)
	for i in 1:days
		println("Part 1: after $(i) days")
		veccy = operation(Vector{Int64}(veccy))
	end
	return length(veccy)
end

function partTwoSingle(vals::Dict{Int64, Int64})
	newDictMap = Dict(key=>0 for key in 0:8)
	for (key, val) in vals
		if key == 0
			newDictMap[6] += val
			newDictMap[8] += val
		end
		if key!= 0 newDictMap[key - 1] += val end
	end
	return newDictMap
end

function partTwoFull(vals::Vector{Int64}, days::Int64)
	firstMap = countmap(vals)
	for i in 1:days
		println("Part 2: doing day $(i)")
		firstMap = partTwoSingle(firstMap)
	end
	return firstMap
end

function main()
	vals = readInput("sixthDayInput.txt")

	# First part
	vals1 = partOne(vals, 80)
	println("Answer for first part is $(vals1)")

	# first part
	println("Answer for first part $(dictSum(partTwoFull(vals, 256)))")
end

main()