"""
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

poss = to_gridposition.(axs)

datapoint_for_right = (collect(1:5), randn(5))

# plot `datapoint_for_right` with an individual y axis on the right for each `axs` on `poss`
for figpos in poss
    right_ax = Axis(figpos[:, :]; yaxisposition=:right, ygridvisible=false) # create a
    scatter!(right_ax, datapoint_for_right...)
end

# output


```

This function is contributed by Julius Krumbiegel on the makie channel of Slack, 2023-08-23.
 """
function to_gridposition(block)
    gc = block.layoutobservables.gridcontent[]
    GridPosition(gc.parent, gc.span, gc.side)
end

"""
`colrange(block)` returns the column range of the block (`Axis`).
"""
colrange(block) = block.layoutobservables.gridcontent[].span.cols


"""
`rowrange(block)` returns the row range of the block (`Axis`).
"""
rowrange(block) = block.layoutobservables.gridcontent[].span.rows
