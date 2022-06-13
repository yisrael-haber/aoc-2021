readInput(path::String) = [[parse(Int64, char) for char in line] for line in readlines(path)]

function getNeighbors(i, j, grid::Vector{Vector{Int64}})
	neighbors = []
	try push!(neighbors, grid[i-1][j]) catch y end
	try push!(neighbors, grid[i+1][j]) catch y end
	try push!(neighbors, grid[i][j-1]) catch y end
	try push!(neighbors, grid[i][j+1]) catch y end
	return Vector{Int64}(neighbors)
end

function getNeighborsNoNine(i, j, grid::Vector{Vector{Int64}})
	neighbors = []
	try if grid[i-1][j] != 9 push!(neighbors, (i-1, j)) end catch y end
	try if grid[i+1][j] != 9 push!(neighbors, (i+1, j)) end catch y end
	try if grid[i][j-1] != 9 push!(neighbors, (i, j-1)) end catch y end
	try if grid[i][j+1] != 9 push!(neighbors, (i, j+1)) end catch y end
	return Vector{Tuple{Int64, Int64}}(neighbors)
end

function lowPoints(grid::Vector{Vector{Int64}})
	lows = Tuple{Int64, Int64}[]
	for idx in 1:length(grid); for jdx in 1:length(grid[1]); if grid[idx][jdx]<minimum(getNeighbors(idx, jdx, grid)); push!(lows, (idx, jdx)) end end end
	return lows, sum([grid[tup[1]][tup[2]] + 1 for tup in lows])
end

function bfs(startNode::Tuple{Int64, Int64}, grid::Vector{Vector{Int64}})
	toProcess = Array{Any}([startNode])
	depths = Int64[0]
	visited = Dict{Tuple{Int64, Int64}, Bool}(node=>false for node in [(i, j) for i in 1:length(grid), j in 1:length(grid[1])])
	visited[startNode] = true
	while length(toProcess)>0
		currentNode = toProcess[1]
		deleteat!(toProcess, 1)
		depth = depths[1]
		deleteat!(depths, 1)
		for childNode in getNeighborsNoNine(currentNode[1], currentNode[2], grid)
			if !visited[childNode] 
				visited[childNode] = true
				push!(toProcess, childNode)
				push!(depths, depth + 1)
			end
		end
	end
	return [key for (key, val) in visited if val==true]
end

function main()
	lines = readInput("ninthDayInput.txt")

	# First part.
	lows = lowPoints(lines)
	println("Answer for first part is $(lows[2])")

	# Second part.
	basins = [bfs(mini, lines) for mini in lows[1]]
	topBasins = reverse(sort([length(basin) for basin in basins]))[1:3]
	println("Answer for second part is: $(topBasins[1])*$(topBasins[2])*$(topBasins[3]) = $(prod(topBasins))")
end

main()