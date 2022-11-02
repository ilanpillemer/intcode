# https://github.com/ilanpillemer/IntCode.jl
using IntCode

echo = IntCode.load("echo")
input = IntCode.load("input")

function run(orig, out::Channel, in::Channel)
    p = copy(orig)
    IntCode.exec(p, out, in)
end

println("part1: final output should be 13787043")
in = Channel(Inf)
out = Channel(Inf)
put!(in, 1)
run(input, out, in)


for x in out
    println("output: $x")
end

println("part2: final output should be 3892695")
in = Channel(Inf)
out = Channel(Inf)

put!(in, 5)
run(input, out, in)

for x in out
    println("output: $x")
end

println("done")
