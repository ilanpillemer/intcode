# https://github.com/ilanpillemer/IntCode.jl
using IntCode
using Random
println("--Day15--")
n = [0, -1]
s = [0, 1]
w = [1, 0]
e = [-1, 0]
pos = [0, 0]
directions = [n, s, w, e]
supply = [-21, 21]
input = IntCode.load("input")
path = Set{Vector{Int64}}()
walls = Set{Vector{Int64}}()
update(pos, direct) = pos + directions[direct]
addwall(pos, direct) = push!(walls, pos + directions[direct])


function pp(path, c)
    start = [0, 0]
    for y = -25:25
        for x = -25:25
            v = [x, y]
            if v == start
                print("0")
                continue
            end
            if v == supply
                print("X")
                continue
            end
            if v in path
                print(c)
            else
                print(" ")
            end
        end
        println()
    end
end

function runonce()
    global pos = [0, 0]
    cin = Channel(Inf)
    cout = Channel(Inf)
    cquit = Channel(Inf)
    prog = copy(input)
    schedule(@task IntCode.exec(prog, cout, cin, cquit))
    while isopen(cout)
        #        try
        move = rand(1:4)
        # prefere somewhere not ever been
        for i ∈ [1, 2, 3, 4]
            opt = pos + directions[i]
            if opt ∉ path && opt ∉ walls
                move = i
            end
        end
        put!(cin, move)
        x = take!(cout)
        if (x == 1)
            global pos = update(pos, move)
            push!(path, pos)
        end
        if (x == 0)
            addwall(pos, move)
        end
        if (x == 2)
            global supply = pos
            global pos = update(pos, move)
            push!(path, pos)
            close(cout)
            println()
            println(pos)
            println("found oxygen supply at $pos")
            pp(collect(path), "#")
            println()

        end
        #        catch err
        #            println(err)
        #        end

    end
end

# explore
previous = -1

while previous != length(path)
    global previous = length(path)
    runonce()
end

supply = [18, -16]

oxy = Set{Vector{Int64}}()
push!(oxy, supply)
push!(path, [0, 0])
println("final walls")
println("path")
#println(path)
println("walls")
#println(walls)
pp(walls, "W")
println()
pp(path, ".")
pp(oxy, "0")

function repair(path, oxy)
    toAdd = Set{Vector{Int64}}()
    for el in oxy
        for x in [1:4]
            opt1 = el + n
            opt2 = el + s
            opt3 = el + w
            opt4 = el + e
            if opt1 in path
                push!(toAdd, opt1)
                delete!(path, opt1)
            end
            if opt2 in path
                push!(toAdd, opt2)
                delete!(path, opt2)
            end
            if opt3 in path
                push!(toAdd, opt3)
                delete!(path, opt3)
            end
            if opt4 in path
                push!(toAdd, opt4)
                delete!(path, opt4)
            end
            delete!(path, el)
        end
    end
    for el in toAdd
        push!(oxy, el)
    end
end

count = 0

while length(path) > 0
    println(length(path))
    global count = count + 1
    repair(path, oxy)
    pp(oxy, "0")
end
println("part 2: $count")
