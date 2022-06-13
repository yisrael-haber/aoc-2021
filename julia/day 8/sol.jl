sortString(str::String) = join(sort([char for char in str]))

function readInput(path::String)
	lines = [vcat([String(val) for val in split(line, " | ")]) for line in readlines(path)]
	linesx, linesy = [line[1] for line in lines], [line[2] for line in lines]
	linesxPlus = [vcat([sortString(String(val)) for val in split(line, " ")]) for line in linesx]
	linesyPlus = [vcat([sortString(String(val)) for val in split(line, " ")]) for line in linesy]
	return linesxPlus, linesyPlus
end

unique(str::String) = ((length(str)==2) || (length(str)==3) || (length(str)==4) || (length(str)==7))

firstPart(linesyPlus::Vector{Vector{String}}) = sum([sum([1 for str in line if unique(str)]) for line in linesyPlus])

containsStr(str1::String, str2::String) = length(str2) == length([char for char in str2 if occursin(char, str1)])

isNine(str::String, fourStr::String) = ((length(str) == 6) && containsStr(str, fourStr))

isThree(str::String, oneStr::String) = ((length(str) == 5) && containsStr(str, oneStr))

isFive(str::String, sixStr::String) = ((length(str) == 5) && containsStr(sixStr, str))

isTwo(str::String, nineStr::String) = ((length(str) == 5) && !containsStr(nineStr, str))

isSix(str::String, sevenStr::String) = ((length(str) == 6) && !containsStr(str, sevenStr))

isZero(str::String, fiveStr::String) = ((length(str) == 6) && !containsStr(str, fiveStr))

function mapper(vals::Vector{Vector{String}})
	lineDicts = Dict{String, Int64}[]
	for line in 1:length(vals[1])
		a = Dict{String, Int64}()
		for idx in 0:9	a[vals[idx+1][line]] = idx end
		push!(lineDicts, a)
	end
	return lineDicts
end

decodeLine(liney::Vector{String}, mapping::Dict{String, Int64}) = parse(Int64, join([mapping[val] for val in liney]))

function secondPart(lines::Vector{Vector{String}}, linesy::Vector{Vector{String}})
	ones = [[str for str in line if length(str)==2][1] for line in lines]
	sevens = [[str for str in line if length(str)==3][1] for line in lines]
	fours = [[str for str in line if length(str)==4][1] for line in lines]
	eights = [[str for str in line if length(str)==7][1] for line in lines]
	sixes = [[str for str in lines[idx] if isSix(str, sevens[idx])][1] for idx in 1:length(lines)]
	nines = [[str for str in lines[idx] if isNine(str, fours[idx])][1] for idx in 1:length(lines)]
	threes = [[str for str in lines[idx] if isThree(str, ones[idx])][1] for idx in 1:length(lines)]
	fives = [[str for str in lines[idx] if isFive(str, sixes[idx])][1] for idx in 1:length(lines)]
	twos = [[str for str in lines[idx] if isTwo(str, nines[idx])][1] for idx in 1:length(lines)]
	zeros = [[str for str in lines[idx] if isZero(str, fives[idx])][1] for idx in 1:length(lines)]
	maps = mapper([zeros, ones, twos, threes, fours, fives, sixes, sevens, eights, nines])
	decodedLines = [decodeLine(linesy[idx], maps[idx]) for idx in 1:length(linesy)]
	return decodedLines
end

function main()
	x, y = readInput("eighthDayInput.txt")

	# First part
	println("Answer for first part is $(firstPart(y))")

	# Second part
	println("Answer for second part is $(sum(secondPart(x, y)))")
end
 
main()