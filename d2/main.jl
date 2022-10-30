# naive beginnings
println("hello, world!")
p = Dict()
open("input", "r") do f
    s = read(f, String)
    for (i, x) in enumerate(eachsplit(s, ","))
        p[i-1] = parse(Int64, x)
    end
end

p[1] = 12
p[2] = 2

function add(x, y)
    a = p[x]
    b = p[y]
    p[a] + p[b]
end

function mul(x, y)
    a = p[x]
    b = p[y]
    p[a] * p[b]
end

pc = 0
opcode = p[pc]
while opcode != 99
    x = pc + 1
    y = pc + 2
    z = pc + 3
    a = p[z]
    if opcode == 1
        global p[a] = add(x, y)
    elseif opcode == 2
        global p[a] = mul(x, y)
    end
    global pc = pc + 4
    global opcode = p[pc]
end
println("Position 0 holds value [$(p[0])]")
