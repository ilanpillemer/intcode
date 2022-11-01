# https://github.com/ilanpillemer/IntCode.jl
using IntCode

echo = IntCode.load("echo")
input = IntCode.load("input")

function run(orig, fn::Function)
    p = copy(orig)
    IntCode.exec(p, fn)
end

accum = run(input, () -> 1)
println("accum $accum")
println("part1: final output should be 13787043")
println(run(input, () -> 5))
println("part2: final output should be 3892695")

println("done")
