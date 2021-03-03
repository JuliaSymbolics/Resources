using Luxor, Colors

function main(fname)
    Drawing(1280, 640, fname)
    origin()

    bbx= BoundingBox()

    # background
    setblend(blend(
    boxtopcenter(bbx),
    boxbottomcenter(bbx),
    RGB(0.18, 0, .24),
    RGB(0.02, 0, 0.14)))
    paint()

    setblend(blend(
    boxtopcenter(bbx),
    boxbottomcenter(bbx),
    RGB(0.02, 0, 0.14),
    RGB(0.18, 0, .24)))
    poly([boxtopleft(bbx),
    between(boxtopleft(bbx), boxtopright(bbx), 360/1280),
    between(boxbottomleft(bbx), boxbottomright(bbx), 590/1280),
    boxbottomleft(bbx)], :fill)

    # show croppable zones
    #@layer begin
    # sethue("red")
    # setline(0.5)
    # rule(boxtopcenter(bbx) + (0, 80))
    # rule(boxbottomcenter(bbx) + (0, -80))
    # rule(boxmiddleleft(bbx) + (80, 0), π/2)
    # rule(boxmiddleright(bbx) + (-80, 0), π/2)
    #end

    # logo
    try
        logo = readsvg("symbolics/symbolics-logo-black-white.svg")
        @layer begin
            translate(boxmiddleleft(bbx) + (250, 0))
            scale(0.4)
            placeimage(logo, centered=true)
        end
    catch e
        @error "Can't load logo"
    end

    # text
    sethue("white")

    # top
    fontsize(90)
    fontface("WorkSans-ExtraBold")
    text("JuliaSymbolics", O + (-130, -170), halign=:left)

    fontsize(29)
    fontface("WorkSans-ExtraBoldItalic")
    text("A fast and modern Computer Algebra System ...", O + (-130, -120), halign=:left)

    # middle
    fontsize(19)
    fontface("WorkSans-Regular")
    textwrap("Symbolics.jl is a pure Julia CAS which uses the Julia core library to its fullest. It is built from the ground up with performance in mind. We use specialized structures for automatic simplification to match the performance of the most fully optimized C++ libraries. It exploits parallelism at every level; our symbolic simplification takes advantage of Julia's task-based multithreading to transform symbolic equations into parallelized Julia code.", 650, O + (-60, -80), leading=30, rightgutter=30)

    # bottom
    fontsize(29)
    fontface("WorkSans-ExtraBoldItalic")
    text("... for a fast and modern language", boxbottomright(bbx) + (-80, -90), halign=:right)

    finish()
    preview()
end

main("/tmp/social-media-preview.png")
