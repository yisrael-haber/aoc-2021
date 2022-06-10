readFromLine(line::String) = [parse(Int64, val) for val in filter(x->x!="", split(line, " "))]

readGrid(lines::Vector{String}) = [readFromLine(line) for line in lines]

readGrids(lines::Vector{String}) = [readGrid(lines[5*i-4:5*i]) for i in 1:(Int64((length(lines))/5))]

function readInput(path::String)
	lines = filter(x->x!="", readlines(path))
	return [parse(Int64, val) for val in split(lines[1], ",")], readGrids(lines[2:length(lines)])
end

mutable struct Grid
	rows::Vector{Vector{Int64}}
	sampledIndices::Dict{Tuple{Int64, Int64}, Int64}
	solved::Bool
end

function initGrid(rows::Vector{Vector{Int64}})
	dicter = Dict{Tuple{Int64, Int64}, Int64}()
	for tuple in [(i,j) for i=1:5 for j=1:5] dicter[tuple] = false end
	return Grid(rows, dicter, false)
end

mutable struct Bingo
	gridList::Vector{Grid}
	checkList::Vector{Vector{Tuple{Int64, Int64}}}
	statuses::Vector{Bool}
	state::Bool
end

initBingo(gridList::Vector{Vector{Vector{Int64}}}, checks) = Bingo([initGrid(grid) for grid in gridList], checks, [false for grid in gridList], false)

function nextPlay!(bingoGame::Bingo, nextCommand::Int64)
	for grid in bingoGame.gridList
		for tuple in [(i,j) for i=1:5 for j=1:5] if grid.rows[tuple[1]][tuple[2]]==nextCommand grid.sampledIndices[tuple] = 1 end end
	end
end

function runGame!(bingoGame::Bingo, commands::Vector{Int64})
	done, command = false, 1
	while !done
		nextPlay!(bingoGame, commands[command])
		for grid in bingoGame.gridList
			res = gridIsSolved(grid, bingoGame.checkList)
			if res 
				done = true
				println("Result of first game is $(commands[command] * sumUnchecked(grid))")
			end
			grid.solved = res
		end
		command += 1
	end
end

function runGame2!(bingoGame::Bingo, commands::Vector{Int64})
	command, val = 1, 0
	while !(allBoardsAreSolved(bingoGame))
		nextPlay!(bingoGame, commands[command])
		for grid in bingoGame.gridList
			res = gridIsSolved(grid, bingoGame.checkList)
			if !res if last(bingoGame) val=sumUnchecked(grid) end end
			grid.solved = res
		end
		command += 1
	end
	return commands[command-1], val
end

rowIsSolved(indices::Vector{Tuple{Int64, Int64}}, grid::Grid) = (sum([grid.sampledIndices[index]==1 for index in indices])==length(indices))

gridIsSolved(grid::Grid, tuples::Vector{Vector{Tuple{Int64, Int64}}}) = (sum([rowIsSolved(col, grid) for col in tuples]) > 0)

sumUnchecked(grid::Grid) = sum([grid.rows[tuple[1]][tuple[2]] for tuple in [(i,j) for i=1:5 for j=1:5 if grid.sampledIndices[(i,j)]==0]])

allBoardsAreSolved(bingoGame::Bingo) = (sum([grid.solved for grid in bingoGame.gridList])==length(bingoGame.gridList))

last(bingoGame::Bingo) = (sum([grid.solved for grid in bingoGame.gridList])==length(bingoGame.gridList)-1)

function main()
	# Loading the data.
	commands, gridList = readInput("fourthDayInput.txt")

	# Generating rules for checking victory of a bingo board.
	colTuples = [[(i, j) for i in 1:5] for j in 1:5]
	rowTuples = [[(i, j) for j in 1:5] for i in 1:5]
	Tuples = union(rowTuples, colTuples)

	# Generating and running the bingo game until first win.
	bingoGame = initBingo(gridList, Tuples)
	runGame!(bingoGame, commands)

	# Second part.
	bingoGame = initBingo(gridList, Tuples)
	lastCommand, sumBefore = runGame2!(bingoGame, commands)
	println("Result of second game is $(lastCommand*(sumBefore-lastCommand))")
end

main()