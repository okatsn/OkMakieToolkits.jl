
"""
`circle_outer(outer_radius)` creates a circle as a vector of points.
"""
function circle_outer(outer_radius)
    decompose(Point2f, Circle(Point2f(0), outer_radius))
end

"""
`circle_inner(outer_radius,linewidth,markersize)` creates the inner circle as a vector of points, where the `linewidth` is scaled by `markersize`.
"""
function circle_inner(outer_radius,linewidth,markersize)
    inner_radius = outer_radius-linewidth/markersize
    decompose(Point2f, Circle(Point2f(0), inner_radius))
end

"""
`mkgen_hollow(markersize::Number; linewidth=1, outer_radius=80)`
generates hollow circle as a `Polygon`, which can be used for the `marker` kwarg of `scatter!`.
"""
function mkgen_hollow(markersize::Number; linewidth=1, outer_radius=80)
    Polygon(circle_outer(outer_radius),
            [circle_inner(outer_radius,linewidth,markersize)])
end

"""
`mkgen_solid(;outer_radius=80)`
generates solid circle as a `Polygon`, which can be used for the `marker` kwarg of `scatter!`.
"""
mkgen_solid(;outer_radius=80)  = Polygon(circle_outer(outer_radius))

"""
`PairedCircleGenerator(outer_radius, linewidth)` returns a pair of functions, solid and hollow, which generates solid and hollow circle of the same outer radius.

# Example
```julia
PCG = PairedCircleGenerator(80, 1)
mksz = [1,2,3]
mksz2 = [0.8,1.7,2.5]
scatter!(...; markersize = mksz, marker = PCG.solid.(mksz))
scatter!(...; markersize = mksz2, marker = PCG.hollow.(mksz2))
```
"""
struct PairedCircleGenerator
    solid
    hollow
    function PairedCircleGenerator(outer_radius, linewidth)
        hollow(markersize) = mkgen_hollow(markersize; linewidth=linewidth, outer_radius=outer_radius)
        solid(markersize) = mkgen_solid(;outer_radius=outer_radius)
        new(solid, hollow)
    end
end
