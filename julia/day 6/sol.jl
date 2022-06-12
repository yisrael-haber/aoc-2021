readInput(path::String) = [parse(Int64, val) for val in split(readlines(path)[1],",")]

# function nextPlaySingle(num::Int64)
# 	if num==0 return [6, 8] end
# 	return [num - 1]
# end

# function nextPlayFull(fishSchool::Vector{Int64})
# 	vecs = Vector{Int64}[]
# 	for val in fishSchool vecs = vcat(vecs, nextPlaySingle(val)) end
# 	return Vector{Int64}(vecs)
# end

# function runSim!(fishSchool::Vector{Int64}, stepNum::Int64)
# 	for i in 1:stepNum
# 		println("After $(i) days")
# 		fishSchool = nextPlayFull(fishSchool)
# 	end
# 	return fishSchool
# end

function yup!(vals::Vector{Int64})
	for idx in 1:length(vals)
		if vals[idx] == 0
			vals[idx] = 6 
			push!(vals, 8)
			continue
		end
		vals[idx] -= 1
	end
end

function yup2!(vals::Vector{Int64}, days::Int64)
	for i in 1:days
		println("After $(i) days")
		yup!(vals)
	end
end

function main()
	vals = readInput("sixthDayInput.txt")

	# first part
	yup2!(vals, 80)
	println("Answer for first part $(length(vals))")
end

main()