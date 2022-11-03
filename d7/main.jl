# https://github.com/ilanpillemer/IntCode.jl
using IntCode
using Combinatorics
input = IntCode.load("input")
# part 1

function get_input(xs)
    () -> pop!(xs)
end

function part1()
    signals = []
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

        (a_in, a_out) = (Channel(Inf), Channel(Inf))
        (b_in, b_out) = (Channel(Inf), Channel(Inf))
        (c_in, c_out) = (Channel(Inf), Channel(Inf))
        (d_in, d_out) = (Channel(Inf), Channel(Inf))
        (e_in, e_out) = (Channel(Inf), Channel(Inf))

        put!(a_in, i)
        put!(b_in, j)
        put!(c_in, k)
        put!(d_in, l)
        put!(e_in, m)

        put!(a_in, 0)
        IntCode.exec(a, a_out, a_in)

        put!(b_in, take!(a_out))
        IntCode.exec(b, b_out, b_in)

        put!(c_in, take!(b_out))
        IntCode.exec(c, c_out, c_in)

        put!(d_in, take!(c_out))
        IntCode.exec(d, d_out, d_in)

        put!(e_in, take!(d_out))
        IntCode.exec(e, e_out, e_in)

        push!(signals, take!(e_out))
    end
    maximum(signals)
end

println("part 1:", part1(), " should be 359142")

function part2()
    signals = []
    for x in permutations([5, 6, 7, 8, 9])
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

        (a_in, a_out) = (Channel(Inf), Channel(Inf))
        (b_in, b_out) = (Channel(Inf), Channel(Inf))
        (c_in, c_out) = (Channel(Inf), Channel(Inf))
        (d_in, d_out) = (Channel(Inf), Channel(Inf))
        (e_in, e_out, e_quit) = (Channel(Inf), Channel(Inf), Channel(0))

        put!(a_in, i)
        put!(b_in, j)
        put!(c_in, k)
        put!(d_in, l)
        put!(e_in, m)


        put!(e_out, 0)
        for x in e_out
            if isopen(e_quit)
                put!(a_in, x)
                schedule(@task IntCode.exec(a, a_out, a_in))
                put!(b_in, take!(a_out))
                schedule(@task IntCode.exec(b, b_out, b_in))
                put!(c_in, take!(b_out))
                schedule(@task IntCode.exec(c, c_out, c_in))
                put!(d_in, take!(c_out))
                schedule(@task IntCode.exec(d, d_out, d_in))
                put!(e_in, take!(d_out))
                schedule(@task IntCode.exec(e, e_out, e_in, e_quit))
            else
                push!(signals, x)
            end
        end
    end
    maximum(signals)
end
println("part 2:", part2(), " should be 4374895")
