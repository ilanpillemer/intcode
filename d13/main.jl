using IntCode
# score is pos 386
function dump(p)
    xs = sort!(collect(keys(p)))
    for x in xs

        if (x - 639) % 41 == 0
            println()
        end
        print("$x:", p[x], ",")
    end
end


pretty_print(p) = pretty_print(p, 0)
function pretty_print(p, score)
    println("my score: $(p[386])")
    blocks = 0
    f = function (x)
        if x == 0
            return "⬛"
        elseif x == 4
            return "⚽"
        elseif x == 2
            return "🟨"
        elseif x == 1
            return "🐰"
        else
            return "🟥"
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
for x = 0:37
    prog[1583+x] = 3

end
#prog[1603] = 3
pretty_print(prog)
IntCode.exec(prog)
println("it should have 230 blocks at the beginning")
function segment(p, out, xxx)
    lives = 3
    while isopen(out)
        x = take!(out)
        y = take!(out)
        z = take!(out)
        #put!(xxx, typeof(x))
        #put!(xxx, "x:$x, y:$y, z:$z")
        w = 41
        h = 25
        offset = 640
        #        t = (w * 3) + 0 + offset
        #        p[t] = 3

        if z == 3
            pos = (w * y) + x + offset
            #            for x2 = 0:38
            #                p[(w*y)+x2+offset] = 3
            #            end

            p[pos] = 3
            #            p[pos-3] = 3
            #            p[pos-2] = 3
            #            p[pos-1] = 3
            #            p[pos+1] = 3
            #            p[pos+2] = 3
            #            p[pos+3] = 3

        end

        if x == -1 && y == 0
            put!(xxx, "XXXXXXXXXXXXXXXXXXXXXXXXXX $z")
        end
    end
end

#dump(prog)
println("play!")
prog[0] = 2


in = Channel(Inf)
out = Channel(Inf)
xxx = Channel(Inf)
quit = Channel(Inf)
schedule(@task segment(prog, out, xxx))
pretty_print(prog)
#put!(in, parse(Int64, chomp(readline())))
schedule(@task IntCode.exec(prog, out, in, quit))
#using Gtk, Graphics
#c = @GtkCanvas()
#win = GtkWindow(c, "Canvas")
#@guarded draw(c) do widget
#    ctx = getgc(c)
#    h = height(c)
#    w = width(c)
#    # Paint red rectangle
#    rectangle(ctx, 0, 0, w, h / 2)
#    set_source_rgb(ctx, 1, 0, 0)
#    fill(ctx)
#    # Paint blue rectangle
#    rectangle(ctx, 0, 3h / 4, w, h / 4)
#    set_source_rgb(ctx, 0, 0, 1)
#    fill(ctx)
#end
#show(c)

current_score = 0


while isopen(quit)
    pretty_print(prog, current_score)
    #    next = chomp(readline())
    #    if next == "j"
    #        x = -1
    #    elseif next == "k"
    #        x = 1
    #    elseif next == " "
    #        x = 0
    #    else
    #        continue
    #    end

    if isopen(in)
        try
            #put!(in, parse(Int64, chomp(readline())))
            put!(in, 0)
        catch
            println("oops")
        end
    end
end

#for x in xxx
#    println(x)
#dump(prog)
#end
