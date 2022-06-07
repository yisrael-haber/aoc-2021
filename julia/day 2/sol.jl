function readlinesComp(path::String)
	lines = readlines(path)
	lines = [split(line, " ") for line in lines]
	lines = [(String(lines[i][1]), parse(Int64, lines[i][2])) for i in 1:length(lines)]
	return lines
end

function findPosFirstPart(commands::Vector{Tuple{String, Int64}})
	hor, depth = 0, 0
	for line in commands
		if line[1] == "forward" hor += line[2] end
		if line[1] == "up" depth -= line[2] end
		if line[1] == "down" depth += line[2] end
	end
	return hor, depth
end

function findPosSecondPart(commands::Vector{Tuple{String, Int64}})
	hor, depth, aim = 0, 0, 0
	for line in commands
		if line[1] == "forward" 
			hor += line[2]
			depth += aim * line[2] 
		end
		if line[1] == "up" aim -= line[2] end
		if line[1] == "down" aim += line[2] end
	end
	return hor, depth
end

function main()
	lines = readlinesComp("secondDayInput.txt")

	# First part
	hor, depth = findPosFirstPart(lines)
	println("Result for first part of the problem is $(hor * depth)")

	# Second part
	hor, depth = findPosSecondPart(lines)
	println("Result for second part of the problem is $(hor * depth)")
end

main()