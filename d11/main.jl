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

function paint(prog, i)
    direction = up
    grid = DefaultDict(0)
    grid[(0, 0)] = i
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
    grid
end

println(length(paint(prog, 0)), " should be 2219")


function width(grid)
    (minx, maxx) = (0, 0)
    for (x, y) in keys(grid)
        minx = x < minx ? x : minx
        maxx = x > maxx ? x : maxx
    end
    return (minx, maxx)
end


function height(grid)
    (miny, maxy) = (0, 0)
    for (x, y) in keys(grid)
        miny = y < miny ? y : miny
        maxy = y > maxy ? y : maxy
    end
    return (miny, maxy)
end

function pp(grid)
    (ax, bx) = width(grid)
    (ay, by) = height(grid)

    for y = by:-1:ay
        f = (x) -> x == 0 ? " " : "#"
        for x = ax:bx
            print(f(grid[(x, y)]))
        end
        println()
    end
end


grid = paint(prog, 1)
pp(grid)

println("grid should have painted the word HAFULAPE")
