using IntCode
using DataStructures

input = IntCode.load("input")
prog = copy(input)

up = 1
down = 2
left = 3
right = 4

links = 0
recht = 1

function rotate(direction, turn)
    if direction == up && turn == links
        return left
    end
    if direction == up && turn == recht
        return right
    end

    if direction == down && turn == links
        return right
    end
    if direction == down && turn == recht
        return left
    end

    if direction == left && turn == links
        return down
    end
    if direction == left && turn == recht
        return up
    end

    if direction == right && turn == links
        return up
    end
    if direction == right && turn == recht
        return down
    end
end

function move(direction, x, y)
    if direction == up
        return (x, y + 1)
    end

    if direction == down
        return (x, y - 1)
    end

    if direction == left
        return (x - 1, y)
    end

    if direction == right
        return (x + 1, y)
    end

end

function part1(prog)
    direction = up
    grid = DefaultDict(0)
    in = Channel(Inf)
    out = Channel(Inf)
    x, y = 0, 0
    (in, out, quit) = (Channel(Inf), Channel(Inf), Channel(Inf))
    schedule(@task IntCode.exec(prog, out, in, quit))
    while isopen(quit)
        reading = grid[(x, y)]
        put!(in, reading)
        colour = take!(out)
        turn = take!(out)
        grid[(x, y)] = colour
        direction = rotate(direction, turn)
        (x, y) = move(direction, x, y)
    end
    length(grid)
end

println(part1(prog), " should be 2219")
