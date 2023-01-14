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
    for y ∈ -25:25
        for x ∈ -25:25
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
        move = rand(1:4)
        # prefer somewhere not ever been
        for i ∈ 1:4
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
pp(walls, "W")
println()
pp(path, ".")

function repair(path, oxy)
    toAdd = Set{Vector{Int64}}()
    for el in oxy
        for i ∈ 1:4
            opt = el + directions[i]
            if opt in path
                push!(toAdd, opt)
                delete!(path, opt)
            end
        end
        delete!(path, el)
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
