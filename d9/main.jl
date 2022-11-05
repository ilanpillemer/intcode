# https://github.com/ilanpillemer/IntCode.jl
using IntCode

echo = IntCode.load("echo")
boost = IntCode.load("boost")
sixteen = IntCode.load("sixteen")
middle = IntCode.load("middle")
opthree = IntCode.load("opthree")


function run(orig)
    println("-------")
    in = Channel(Inf)
    out = Channel(Inf)
    p = copy(orig)
    IntCode.exec(p, out, in)
    for x in out
        println("output: $x")
    end
    println("-------")
end

function run(orig, i)
    in = Channel(Inf)
    out = Channel(Inf)
    put!(in, i)

    p = copy(orig)
    IntCode.exec(p, out, in)
    for x in out
        println("output: $x")
    end
    close(in)
    close(out)
end

println("part1")
run(boost, 1)
println("final output should be 3497884671")

println("part2")
run(boost, 2)
println("final output should be 46470")

#run(echo)
#run(sixteen)
#run(middle, 12)
#
#run(opthree, 23)
