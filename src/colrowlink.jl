"""
`colrange(block)` returns the column range of the block (`Axis`).
"""
colrange(block) = block.layoutobservables.gridcontent[].span.cols


"""
`rowrange(block)` returns the row range of the block (`Axis`).
"""
rowrange(block) = block.layoutobservables.gridcontent[].span.rows


samecol(ax1, ax2) = colrange(ax1) == colrange(ax2)
samerow(ax1, ax2) = rowrange(ax1) == rowrange(ax2)


"""
`keeponlysamecollinked!(axs::Vector{Axis})` keeps x-axis of each `axs` stay linked only to those axes of the same column range. It has the same effect as the followings:

```julia
axs = filter(x -> x isa Axis, f.figure.content)
for ax1 in axs
    keepat!(ax1.xaxislinks, samecol.(Ref(ax1), ax1.xaxislinks))
end
```

!!! warning
    - Noted that `those axes` is not limited in the collection of `axs`.
    - Input `axs` combined from different grid layout might lead to malfunction, since it checks only the span of gridcontent to see the row or column range are identical, but do not check whether the origin of gridcontent is the same.

See also: `samecol`, `samerow`, `colrange`, `rowrange`
"""
function keeponlysamecollinked!(axs::Vector{Axis})
    for ax1 in axs
        keepat!(ax1.xaxislinks, samecol.(Ref(ax1), ax1.xaxislinks))
    end
end

"""
`keeponlysamerowlinked!(axs::Vector{Axis})` is similar to `keeponlysamecollinked!`, but for axis on the same row range stay linked on y axis.

See the docstring of `keeponlysamecollinked!`.
"""
function keeponlysamerowlinked!(axs)
    for ax1 in axs
        keepat!(ax1.yaxislinks, samerow.(Ref(ax1), ax1.yaxislinks))
    end
end
