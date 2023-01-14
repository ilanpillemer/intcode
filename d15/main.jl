# https://github.com/ilanpillemer/IntCode.jl
using IntCode
using Random
println("--Day15--")
n = [0, -1]
s = [0, 1]
w = [1, 0]
e = [-1, 0]
pos = [0, 0]
path = Set{Vector{Int64}}()
function update(pos, direct)
    #println("received $pos and $direct")
    if direct == 1
        global pos = pos + n
    end
    if direct == 2
        global pos = pos + s
    end
    if direct == 3
        global pos = pos + w
    end
    if direct == 4
        global pos = pos + e
    end
    #println("returned $pos")
    pos
end
#Accept a movement command via an input instruction.
#Send the movement command to the repair droid.
#Wait for the repair droid to finish the movement operation.
#Report on the status of the repair droid via an output instruction.




in = Channel(Inf)
out = Channel(Inf)
quit = Channel(Inf)
input = IntCode.load("input")
prog = copy(input)

schedule(@task IntCode.exec(prog, out, in, quit))
while isopen(out)
    try
        move = rand(1:4)
        put!(in, move)
        x = take!(out)
        if (x == 1)
            global pos = update(pos, move)
            push!(path, pos)
        end
        if (x == 2)
            global pos = update(pos, move)
            push!(path, pos)
            close(out)
            println()
            println(pos)



        end
        #print("$x $pos")
        #println()
    catch err
        println(err)
    end
end
println("final path")
#println(path)
function pp(path)
    start = [0, 0]
    X = [18, -16]
    for y = -20:20
        for x = -20:20
            v = [x, y]
            if v == start
                print("0")
                continue
            end
            if v == X
                print("X")
                continue
            end
            if v in collect(path)
                print("#")
            else
                print(" ")
            end
        end
        println()
    end
end

pp(path)
