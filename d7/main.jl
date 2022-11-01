# https://github.com/ilanpillemer/IntCode.jl
using IntCode
using Combinatorics
input = IntCode.load("input")
# part 1

function get_input(xs)
    () -> pop!(xs)
end

function part1()
    res = 0
    signals = []
    phase_setting = ""
    for x in permutations([0, 1, 2, 3, 4])
        i = x[1]
        j = x[2]
        k = x[3]
        l = x[4]
        m = x[5]

        a = copy(input)
        b = copy(input)
        c = copy(input)
        d = copy(input)
        e = copy(input)

        res = IntCode.exec(a, get_input([0, i]))
        res = IntCode.exec(b, get_input([res[1], j]))
        res = IntCode.exec(c, get_input([res[1], k]))
        res = IntCode.exec(d, get_input([res[1], l]))
        res = IntCode.exec(e, get_input([res[1], m]))
        push!(signals, res[1])
    end
    maximum(signals)
end

println(part1(), " should be 359142")
println("part1: done")
