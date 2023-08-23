abstract type TwinAxis end

struct LeftAxis <: TwinAxis
    color
    other
end

struct RightAxis <: TwinAxis
    color
    other
end


"""
`twinaxis(figpos::GridPosition; left_color=:black, right_color=:dodgerblue, left_axis=(;), right_axis=(;))` returns `(left_ax, right_ax)` for the left- and right- axis of the same plot on `figpos`.

By default, `yticklabelcolor` `ytickcolor` and left (right) spinecolor for left (right) axis is set to `left_color` (`right_color`). However, these default settings can be overwritten by assigning the name tuple for axis' attribute to keyword argument `left_axis` (`right_axis`).

# Example

```jldoctest
using Makie, OkMakieToolkits
f = Figure()
left_ax, right_ax = twinaxis(f[1,1];
    left_color = :black, # left side looks all in black
    left_axis = (; yticklabelcolor = :blue) # despite left yticklabel; its blue.
)

left_ax.yticklabelcolor[]

# output
RGBA{Float32}(0.0f0,0.0f0,1.0f0,1.0f0)
```

Ref: https://beautiful.makie.org/dev/examples/generated/2d/lines/line_twin_axis/
"""
function twinaxis(figpos::GridPosition; left_color=:black, left_axis=(;), right_color=:dodgerblue, right_axis=(;))
    left_ax = _pinax(figpos, LeftAxis(left_color, left_axis))
    right_ax = _pinax(figpos, RightAxis(right_color, right_axis))
    return (left_ax, right_ax)
end

function _pinax(figpos, ax::LeftAxis)
    left_ax = Axis(figpos; rightspinevisible=false,
        yticklabelcolor=ax.color,
        leftspinecolor=ax.color,
        ytickcolor=ax.color,
        ax.other...)
    return left_ax
end

function _pinax(figpos, ax::RightAxis)
    right_ax = Axis(figpos; yaxisposition=:right,
        yticklabelcolor=ax.color,
        rightspinecolor=ax.color,
        ytickcolor=ax.color,
        ygridvisible=false,
        ax.other...)
    return right_ax
end
