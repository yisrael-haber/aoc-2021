function readlinesComp(path::String)
	lines = readlines(path)
	lines = [[parse(Int64, char) for char in line] for line in lines]
	return lines
end

function mostCommon(column::Vector{Int64})
	if sum(column) >= 0.5 * length(column) return 1 end 
	return 0
end

function mostCommonCO(column::Vector{Int64})
	if sum(column) < 0.5 * length(column) return 1 end 
	return 0
end

function fromBinToNum(bits::Vector{Int64})
	return sum([bits[i]*2^(length(bits) - i) for i in 1:length(bits)])
end

function gammaEpsilon(lines::Vector{Vector{Int64}})
	cols = [[lines[i][col] for i in 1:length(lines)] for col in 1:length(lines[1])]
	gammaBits = [mostCommon(col) for col in cols]
	epsilonBits = [1 - val for val in gammaBits]
	return fromBinToNum(gammaBits), fromBinToNum(epsilonBits)
end

function bitCriteria(numList::Vector{Vector{Int64}}, crit::Int64, col::Int64)
	if crit == 1
		if length(numList) == 1 return numList end
		# println("OXY, $(length(numList)) number left")
		mostCommonBit = mostCommon([numList[j][col] for j in 1:length(numList)])
		return [line for line in numList if line[col]==mostCommonBit]
	end
	if crit == 0
		if length(numList) == 1 return numList end
		# println("CO, $(length(numList)) number left")
		mostCommonBit = mostCommonCO([numList[j][col] for j in 1:length(numList)])
		return [line for line in numList if line[col]==mostCommonBit]
	end
end

function oxygenCO2(lines::Vector{Vector{Int64}})
	firstCol = [lines[i][1] for i in 1:length(lines)]
	mostCommonBitCurrOxy = mostCommon(firstCol)
	oxyNums = [line for line in lines if line[1]==mostCommonBitCurrOxy]
	CONums = [line for line in lines if line[1]!=mostCommonBitCurrOxy]
	for i in 2:length(lines[1])
		oxyNums = bitCriteria(oxyNums, 1, i)
		CONums = bitCriteria(CONums, 0, i)
	end
	return fromBinToNum(oxyNums[1]), fromBinToNum(CONums[1])
end

function main()
	lines = readlinesComp("thirdDayInput.txt")
	
	# First part
	gamma, epsilon = gammaEpsilon(lines)
	println("Result for first part is $(gamma * epsilon)")

	# Second part
	oxy, CO = oxygenCO2(lines)
	println("Result for second part is $(oxy * CO)")
end

main()