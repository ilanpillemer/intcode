# naive beginnings
println("hello, world!")

function load(name)
    p = Dict()
    open(name, "r") do f
        s = read(f, String)
        for (i, x) in enumerate(eachsplit(s, ","))
            p[i-1] = parse(Int64, x)
        end
    end
    return p
end

orig = load("input")

function add(p, x, y)
    a = p[x]
    b = p[y]
    p[a] + p[b]
end

function mul(p, x, y)
    a = p[x]
    b = p[y]
    p[a] * p[b]
end

function exec(p)
    pc = 0
    opcode = p[pc]
    while opcode != 99
        x = pc + 1
        y = pc + 2
        z = pc + 3
        a = p[z]
        if opcode == 1
            p[a] = add(p, x, y)
        elseif opcode == 2
            p[a] = mul(p, x, y)
        end
        pc = pc + 4
        opcode = p[pc]
    end
    p[0]
end

function run(orig, x, y)
    p = copy(orig)
    p[1] = x
    p[2] = y
    exec(p)
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

println("part 1: $(p1) : $(p1==10566835)") # should be 10566835
println("part 2: $(p2) : $(p2==2347)") # should be 2347
