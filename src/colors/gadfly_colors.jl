"""
`gadfly_default(n)` generate a vector of `LCHab <: Colorant` colors, which are default colors of Gadfly.
"""
function gadfly_default(n)
    return distinguishable_colors(
        n,
        LCHab(70, 60, 240);
        transform=c -> deuteranopic(c, 0.5),
        lchoices=Float64[65, 70, 75, 80],
        cchoices=Float64[0, 50, 60, 70],
        hchoices=range(0, 330; length=24)
    )
    # or using Gadfly; Scale.color_discrete_hue(n)
end
