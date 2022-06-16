using Statistics

readInput(path::String) = [[char for char in line] for line in readlines(path)]
calculateScore(toSumFor::Vector{Char}, scoreDict::Dict{Char, Int64}) = sum([scoreDict[char] for char in toSumFor])
calculateScore2(toSumFor::Vector{Char}, scoreDict::Dict{Char, Int64}) = sum([scoreDict[toSumFor[idx]]*5^(idx-1) for idx in 1:length(toSumFor)])

function firstPart(lines::Vector{Vector{Char}}, forward::Dict{Char, Char}, backward::Dict{Char, Char}, scores::Dict{Char, Int64})
	total = Char[]
	for line in lines
		stack = []
		for char in line
			if char in collect(keys(forward)) push!(stack, char) 
			elseif char in collect(keys(backward))
				if last(stack) != backward[char]
					push!(total, char)
					break
				else pop!(stack) end
			end
		end
	end
	return calculateScore(total, scores)
end

function secondPart(lines::Vector{Vector{Char}}, forward::Dict{Char, Char}, backward::Dict{Char, Char}, scores::Dict{Char, Int64})
	total = Int64[]
	for line in lines
		stack, valid = Char[], true
		for char in line
			if char in collect(keys(forward)) push!(stack, char) 
			elseif char in collect(keys(backward))
				if last(stack) != backward[char]
					valid = false
					break 
				else pop!(stack) end
			end
		end
		if valid push!(total, calculateScore2(stack, scores)) end
	end
	return Int64(median(total))
end


function main()
	forward = Dict('('=>')', '['=>']', '{'=>'}', '<'=>'>')
	backward = Dict(value => key for (key, value) in forward)
	scores = Dict(')'=>3, ']'=>57, '}'=>1197, '>'=>25137)

	# First part.
	lines = readInput("tenthDayInput.txt")
	println("Answer for first part is $(firstPart(lines, forward, backward, scores))")

	# Second part.
	scores = Dict('('=>1, '['=>2, '{'=>3, '<'=>4)
	println("Answer for second part is $(secondPart(lines, forward, backward, scores))")
end

main()