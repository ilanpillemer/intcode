using IntCode
# score is pos 2689
function pretty_print(p)
    #println("score: $(p[2689])")
    blocks = 0
    f = function (x)
        if x == 0
            return " "
        else
            return x
        end
    end
    xs = sort!(collect(keys(p)))
    for x in xs
        if x > 638 && x < 1664
            if p[x] == 2
                blocks = blocks + 1
            end
            #print("pos $x: ")
            if (x - 639) % 41 == 0
                println()
            end
            print(f(p[x]), "")
        end
    end
    println()
    println("blocks: $blocks")
end
input = IntCode.load("input")
prog = copy(input)

pretty_print(prog)
IntCode.exec(prog)
println("it should have 230 blocks at the beginning")
