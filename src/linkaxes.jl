"""
Given a figure,
link all axes in `f.content` (`[... for ax in f.content if ax isa Axis]`).

# Example
```
using Makie, OkMakieToolkits
x = 1:10
y1 = randn(10)
y2 = 1 .+ 2 * randn(10)
f = Figure()
ax1 = Axis(f[1, 1])
ax2 = Axis(f[1, 2])
lines!(ax1, x, y1)
scatter!(ax2, x, y2)

# This assures figure is up-to-date and prevents potential changes on the limits of axes (e.g., slightly shift between linked axes).
Makie.update_state_before_display!(f)

# Call `Makie.linkaxis!(axs...)` for any `ax` on `f`.
linkaxes!(f) # equivalent to linkaxes!(ax1, ax2)
```

[Inspired by this reply](https://discourse.julialang.org/t/how-to-link-axes-in-a-makie-figure/62622/2?u=okatsn)

See also `OkMakieToolkits.linkxaxes!`, `OkMakieToolkits.linkyaxes!`
"""
function OkMakieToolkits.linkaxes!(f::Figure)
    __linkaxes!(linkaxes!, f)
end

"""
See `OkMakieToolkits.linkaxes!`.
"""
function OkMakieToolkits.linkxaxes!(f::Figure)
    __linkaxes!(linkxaxes!, f)
end

"""
See `OkMakieToolkits.linkaxes!`.
"""
function OkMakieToolkits.linkyaxes!(f::Figure)
    __linkaxes!(linkyaxes!, f)
end

function __linkaxes!(fn, f::Figure)
    @assert fn in [linkaxes!, linkxaxes!, linkyaxes!]
    # CHECKPOINT: it is useless to update state here.
    # Makie.update_state_before_display!(f)
    axs = filter(x -> x isa Axis, f.content)
    fn(axs...)
    @info "Axes of the following titles are linked."
    [(axt = ax.title[];
    ifelse(isempty(axt), "nothing", axt)) for ax in axs] .|> x -> println("title: $x")
    return axs
end
