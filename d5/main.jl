# https://github.com/ilanpillemer/IntCode.jl
using IntCode

echo = IntCode.load("echo")
input = IntCode.load("input")

function run(orig)
    p = copy(orig)
    IntCode.exec(p)
end

IntCode.set_input(1)
run(input)
println("part1: final output should be 13787043")
IntCode.set_input(5)
run(input)
println("part2: final output should be 3892695")

println("done")
