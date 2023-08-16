"""
`twinaxis(figpos::GridPosition)` returns `(ax1, ax2)` for the left- and right- axis of the
same plot on `figpos`.

# Example

```julia
f = Figure()
ax1, ax2 = twinaxis(f[1,1])
```

Ref: https://beautiful.makie.org/dev/examples/generated/2d/lines/line_twin_axis/
"""
function twinaxis(figpos::GridPosition; ax1=(; yticklabelcolor=:black), ax2=(; ytickcolor=:dodgerblue))
    ax1 = Axis(figpos; rightspinevisible=false, yticklabelcolor=:black, ax1...)
    ax2 = Axis(figpos; yaxisposition=:right,
        yticklabelcolor=:dodgerblue,
        rightspinecolor=:dodgerblue,
        ytickcolor=:dodgerblue,
        ygridvisible = false,
        ax2...)
    return (ax1, ax2)
end
