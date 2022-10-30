# https://github.com/ilanpillemer/IntCode.jl
using IntCode

orig = IntCode.load("input")

function run(orig, x, y)
    p = copy(orig)
    p[1] = x
    p[2] = y
    IntCode.exec(p)
end

function run2(orig)
    for noun = 0:99, verb = 0:99
        output = (run(orig, noun, verb))
        if output == 19690720
            return noun * 100 + verb
        end
    end
end

p1 = run(orig, 12, 2)
p2 = run2(orig)

# https://adventofcode.com/2019/day/2
println("see https://adventofcode.com/2019/day/2")

println("part 1: $(p1) : $(p1==10566835)") # should be 10566835
println("part 2: $(p2) : $(p2==2347)") # should be 2347
