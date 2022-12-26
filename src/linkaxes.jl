"""
Given a figure,
link all axes in `f.content` (`[... for ax in f.content if ax isa Axis]`).

[Inspired by this reply](https://discourse.julialang.org/t/how-to-link-axes-in-a-makie-figure/62622/2?u=okatsn)
"""
function OkMakieToolkits.linkaxes!(f::Figure)
    __linkaxes!(linkaxes!, f)
end

function OkMakieToolkits.linkxaxes!(f::Figure)
    __linkaxes!(linkxaxes!, f)
end

function OkMakieToolkits.linkyaxes!(f::Figure)
    __linkaxes!(linkyaxes!, f)
end

function __linkaxes!(fn, f::Figure)
    @assert fn in [linkaxes!, linkxaxes!, linkyaxes!]
    axs = filter(x -> x isa Axis, f.content)
    fn(axs...)
    @info "Axes of the following titles are linked."
    [(axt = ax.title[];
        ifelse(isempty(axt), "nothing", axt)) for ax in axs] .|> x -> println("title: $x")
    return axs
end
