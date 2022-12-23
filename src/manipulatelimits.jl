
"""
`expandylim!(ax, upper_expand)` expand the upper limit of y axis to a ratio of `upper_expand` of the original y range (`ymax - ymin`).

# Example
```julia
expandylim!(ax, 0.25)
```

"""
function expandylim!(ax, upper_expand)
    xmin, ymin, xmax, ymax = getxylimits(ax)
    diffy0 = ymax - ymin
    newymax = ymin + diffy0*(1+upper_expand)
    ylims!(ax, ymin, newymax)
end

"""
`shrinkylim!(ax, ydatas::Vector{<:Number}; extent = 0.15)`
fit y-limits to the input `ydatas` to with a certain `extent`.
"""
function shrinkylim!(ax, ydatas::Vector{<:Number}; extent = 0.15)
    ymin, ymax = extrema(vcat(ydatas...))
    # ymin = 0; ymax = 10
    Δy = ymax - ymin
    symin, symax = map((f, ym) -> f(ym, Δy*extent), [-,+], [ymin, ymax])
    ylims!(ax, symin, symax)
end


"""
# Example
```julia
xmin, ymin, xmax, ymax = getxylimits(ax)
```
"""
function getxylimits(ax)
    axlimtemp = ax.finallimits[]
    ((xmin, ymin), (xmax,ymax)) = map(f -> f(axlimtemp), (minimum, maximum))
    # see https://juliadatascience.io/glmakie
    return xmin, ymin, xmax, ymax
end

"""
`expandxylim!(ax, upper_expand_x, lower_expand_x, lower_expand_y, upper_expand_y)`
TODO: merge with expandylim! in makietools.jl
"""
function expandxylim!(ax, upper_expand_x, lower_expand_x, lower_expand_y, upper_expand_y)
    xmin, ymin, xmax, ymax = getxylimits(ax)
    diffy0 = ymax - ymin
    diffx0 = xmax - xmin
    newymax = ymin + diffy0*(1+upper_expand_y)
    newxmax = xmin + diffx0*(1+upper_expand_x)

    newymmin = ymin - diffy0*lower_expand_y
    newxmmin = xmin - diffx0*lower_expand_x
    ylims!(ax, newymmin, newymax)
    xlims!(ax, newxmmin, newxmax)
end

function expandxylim!(ax, f, upper_expand_x, lower_expand_x, lower_expand_y, upper_expand_y)
    display(f); # this is required for expandxylim! to work properly
    expandxylim!(ax, upper_expand_x, lower_expand_x, lower_expand_y, upper_expand_y)
end


# TODO: log plots where all powers of 10 should be shown. https://docs.makie.org/v0.19.0/examples/blocks/axis/index.html#logticks

# TODO: Try recipes: https://docs.makie.org/stable/documentation/recipes/index.html
