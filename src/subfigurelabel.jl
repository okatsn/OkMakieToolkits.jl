# See this for how to write an iterator:
# https://docs.julialang.org/en/v1/manual/interfaces/
struct SubfigureLabel
    count::Int
end

function Base.iterate(SL::SubfigureLabel, state=1)
    if SL.count > 26
        error("Sub-figure labels more than 26 is not supported.")
    end

    alllabels = 'a':'z'
    if state > SL.count
        out = nothing
    else
        out = ("($(alllabels[state]))", state + 1)
    end
    return out
end

Base.length(SL::SubfigureLabel) = SL.count

"""
```julia
fig = Figure(; resolution=(1100, 580))
f0 = fig[1, 1] = GridLayout() # This is intended since `rowsize!` can only modify GridLayout
f11 = f0[1, 1] = GridLayout()
f21 = f0[2, 1] = GridLayout()

labels = ["(a)", "(b)"]
panels = [f11, f21]

labelpanels!(labels, panels; fontsize = 20)
```

It takes keyword arguments as `Label`. By default:

```
kwargs = (; fontsize=18,
font=:bold,
padding=(0, 5, 5, 0),
halign=:right,)
```

Referring: https://docs.makie.org/stable/tutorials/layout-tutorial/#subplot_labels
"""
function labelpanels!(labels, panels; kwargs...)
    for (label, layout) in zip(labels, panels)
        Label(
            layout[1, 1, TopLeft()],
            label;
            fontsize=18,
            font=:bold,
            padding=(0, 5, 5, 0),
            halign=:right,
            kwargs...
        )
    end
end
