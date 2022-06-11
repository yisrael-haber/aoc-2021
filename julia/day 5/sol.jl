function readInput(path::String)
	lines = [vcat([String(val) for val in split(line, " -> ")]) for line in readlines(path)]
	lines = [string(line[1], ",", line[2]) for line in lines]
	lines = [[parse(Int64, str) for str in split(line, ",")] for line in lines]
	return lines
end

isParr(vals::Vector{Int64}) = ((vals[1]==vals[3]) || (vals[2]==vals[4]))

getVec(val1::Int64, val2::Int64) = [val for val in union(val1:val2, val2:val1)]

diag(vals::Vector{Int64})  = ((vals[4]-vals[2])==(vals[3]-vals[1])) || (-(vals[4]-vals[2])==(vals[3]-vals[1]))

function findDiag(vals::Vector{Int64})
	if (vals[4]-vals[2])==(vals[3]-vals[1])
		if (vals[1] < vals[3]) return [(vals[1] + i, vals[2] + i) for i in 0:(vals[3]-vals[1])] end
		return [(vals[3] + i, vals[4] + i) for i in 0:(vals[1]-vals[3])]
	end
	if (vals[4]-vals[2])==-(vals[3]-vals[1])
		if (vals[1] < vals[3]) return [(vals[1] + i, vals[2] - i) for i in 0:(vals[3]-vals[1])] end
		return [(vals[3] + i, vals[4] - i) for i in 0:(vals[1]-vals[3])]
	end
end

# function findRec(vals::Vector{Int64})
# 	if vals[1] == vals[3] return [(vals[1], val) for val in getVec(vals[2], vals[4])] end
# 	if vals[2] == vals[4] return [(val, vals[2]) for val in getVec(vals[1], vals[3])] end
# end

function findRec(vals::Vector{Int64})
	if vals[1] == vals[3] return [(vals[1], val) for val in union(vals[2]:vals[4], vals[4]:vals[2])] end
	if vals[2] == vals[4] return [(val, vals[2]) for val in union(vals[1]:vals[3], vals[3]:vals[1])] end
end

function main()
	lines = readInput("fifthDayInput.txt")

	# First part
	horiVerti = filter(x->isParr(x), lines)
	locations = []
	for vec in horiVerti for tuple in findRec(vec) push!(locations, tuple) end end
	uniq = unique(locations)
	counts = Dict([(i,count(x->x==i,locations)) for i in uniq])
	nums = length([val[1] for val in counts if val[2]>=2])
	println("Answer for first part: $(nums)")

	# Second part
	diagVecs = filter(x->diag(x), lines)
	diagLoc = []
	for vec in diagVecs for tuple in findDiag(vec) push!(diagLoc, tuple) end end
	uniqDiag = unique(diagLoc)
	countsDiag = Dict([(i,count(x->x==i,diagLoc)) for i in uniqDiag])
	newCounts = merge(+, countsDiag, counts)
	println("Answer for second part: $(length([val[1] for val in newCounts if val[2]>=2]))")
end

main()