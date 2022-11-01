# https://github.com/ilanpillemer/IntCode.jl
using IntCode

echo = IntCode.load("echo")
input = IntCode.load("input")

function run(orig)
    p = copy(orig)
    IntCode.exec(p)
end

IntCode.set_input(1)
accum = run(input)
println("accum $accum")
println("part1: final output should be 13787043")
IntCode.set_input(5)
println(run(input))
println("part2: final output should be 3892695")

println("done")
