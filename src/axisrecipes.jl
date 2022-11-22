

"""
`blankaxis!(fpos, xmin::T, ymin::T, xmax::T, ymax::T) where {T<:AbstractFloat}`
creates an empty Makie Axis object at grid position `fpos`.

# Example
```julia
f = Figure(;resolution=(1400,1000))
gleft = f[1:3, 1] = GridLayout()
gright = f[1:3, 2:3] = GridLayout()
fpos = gright[0, :]
blankaxis!(fpos, xmin, ymin, xmax, ymax)
```
"""
function blankaxis!(fpos, xmin::T, ymin::T, xmax::T, ymax::T) where {T<:AbstractFloat}
    ax = CairoMakie.Axis(fpos,
        xticks = [xmin, xmax],
        yticks = [ymin, ymax],
        bottomspinevisible = false,
        leftspinevisible = false,
        xticklabelsvisible = false,
        yticklabelsvisible = false,
        xgridvisible = false,
        ygridvisible = false,
        topspinevisible = false,
        rightspinevisible = false,
    )
return ax
end




"""
`secondyaxis(f_grid; color = :black, ylabel = "y")` returns an `Axis` object of y axis to the right-hand side, with default settings for yyplot.

# Example
```julia
f = Figure()
ax_right = secondyaxis(f[1,1]; color=:red)


```
that you can do `lines!(ax_right, ...)`

# Further reading
- [Is it possible to add a secondary y axis?](https://github.com/JuliaPlots/Makie.jl/issues/816)
"""
function secondyaxis(f_grid; color = :black, ylabel = "y")
        axright = CairoMakie.Axis(f_grid; ylabel = ylabel,
        yaxisposition =:right,
        xlabelvisible =false,
        xticklabelsvisible =false,
        xticksvisible=false,
        xgridvisible = false,
        ygridvisible = false,
        ylabelcolor = color,
        yticklabelcolor= color,
        ytickcolor=color,
        yminortickcolor = color
    )
    return axright
end


function setxticklabelsoff!(ax)
    ax.xticklabelsvisible[] = false
end
