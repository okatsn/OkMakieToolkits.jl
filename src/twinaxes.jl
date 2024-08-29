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
using CairoMakie, OkMakieToolkits
f = Figure()
left_ax, right_ax = twinaxis(f[1,1];
    left_color = :black, # left side looks all in black
    left_axis = (; yticklabelcolor = :blue) # despite left yticklabel; its blue.
)

left_ax.yticklabelcolor[]

# output
:blue
```

Ref: https://beautiful.makie.org/dev/examples/generated/2d/lines/line_twin_axis/
"""
function twinaxis(figpos::GridPosition; left_color=:black, left_axis=(;), right_color=:dodgerblue, right_axis=(;))
    left_ax = _pinax(figpos, LeftAxis(left_color, left_axis))
    right_ax = _pinax(figpos, RightAxis(right_color, right_axis))
    return (left_ax, right_ax)
end

function _theother(ax)
    if ax.yaxisposition[] == :left
        return RightAxis
    elseif ax.yaxisposition[] == :right
        return LeftAxis
    else
        error("Y-Axis position is nether left or right")
    end
end

"""
`twinaxis(ax::Axis; color=:dodgerblue, other=(;))`:
Given an `ax`, the `ax2::Axis` of the other side is pinned to the grid position of `ax`; it returns `ax2`.

# Example

```jldoctest
using CairoMakie, AlgebraOfGraphics, DataFrames

f = Figure()
df = DataFrame(a=repeat(1:3, outer=2),
    b=randn(6),
    d=repeat(1:3, inner=2),
    e=["(a)", "(a)", "(a)", "(b)", "(b)", "(b)"])

plts = data(df) * visual(Lines) * mapping(:a, :b) * mapping(layout=:e)

draw!(f[1, 1], plts)

axs = filter(x -> x isa Axis, f.content) # a vector of two axes, panel (a) and (b)

twaxs = twinaxis.(axs)

x = collect(1:5)
y = randn(5)

for ax in twaxs
    scatter!(ax, x, y)
end

for (ax1, ax2) in zip(axs, twaxs)
    @assert ax1.yaxisposition[] == :left
    @assert ax2.yaxisposition[] == :right
end

# output


```
"""
function twinaxis(ax::Axis; color=:dodgerblue, other=(;))
    OtherAxis = _theother(ax)
    gridpos = to_gridposition(ax)
    _pinax(gridpos[:, :], OtherAxis(color, other))
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
