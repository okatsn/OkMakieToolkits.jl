"""
`twinaxis(figpos::GridPosition; left_color=:black, right_color=:dodgerblue, left_ax=(;), right_ax=(;))` returns `(left_ax, right_ax)` for the left- and right- axis of the same plot on `figpos`.

By default, `yticklabelcolor` `ytickcolor` and left (right) spinecolor for left (right) axis is set to `left_color` (`right_color`). However, these default settings can be overwritten by assigning the name tuple for axis' attribute to keyword argument `left_ax` (`right_ax`).

# Example

```jldoctest
using Makie, OkMakieToolkits
f = Figure()
left_ax, right_ax = twinaxis(f[1,1];
    left_color = :black, # left side looks all in black
    left_ax = (; yticklabelcolor = :blue) # despite left yticklabel; its blue.
)

left_ax.yticklabelcolor[]

# output
RGBA{Float32}(0.0f0,0.0f0,1.0f0,1.0f0)
```

Ref: https://beautiful.makie.org/dev/examples/generated/2d/lines/line_twin_axis/
"""
function twinaxis(figpos::GridPosition; left_color=:black, right_color=:dodgerblue, left_ax=(;), right_ax=(;))
    left_ax = Axis(figpos; rightspinevisible=false,
        yticklabelcolor=left_color,
        leftspinecolor=left_color,
        ytickcolor=left_color,
        left_ax...)
    right_ax = Axis(figpos; yaxisposition=:right,
        yticklabelcolor=right_color,
        rightspinecolor=right_color,
        ytickcolor=right_color,
        ygridvisible=false,
        right_ax...)
    return (left_ax, right_ax)
end
