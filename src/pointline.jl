"""
# Example
```julia
pointline!(ax::Axis, head, tail; color=:black,
        text="", align=(:left, :center), # see https://docs.makie.org/stable/examples/plotting_functions/text/#alignment
        fontsize=18
    )
```

`pointline!` plot a point at `head`, with a tail until `tail` where `text` is appended.

If `align == :auto`, alignment is automatically decided according to the phase angle of `tail .- head` (only supported 2D).
"""
function pointline!(ax::Axis, head, tail; color=:black,
    text="", align=:auto, # see https://docs.makie.org/stable/examples/plotting_functions/text/#alignment
    fontsize=18
)
    scatter!(ax, head; color=color)
    linesegments!(ax, [head, tail]; color=color)

    if align == :auto
        tail0 = tail .- head |> Tuple
        θ = angled2(tail0, (1.0, 0.0))
        align = (leftorright(θ), bottomortop(θ))
    end

    text!(ax, tail; text=text, color=color, align=align, fontsize=fontsize)
end

"""
`angled2(a, b)` returns the angle **in degree** between a and b against b, where counterclockwise from `b` to `a` will be defined as positive.

See https://discourse.julialang.org/t/how-to-find-angle-between-two-vectors/68149/4
and also https://github.com/JeffreySarnoff/AngleBetweenVectors.jl
"""
function angled2(a::Tuple{T,T}, b::Tuple{T,T}) where {T<:Real}
    a = vcat(collect(a), 0.0)
    b = vcat(collect(b), 0.0)

    axb = cross(a, b)
    clockwiseness = axb[3] < 0.0 ? 1.0 : -1.0 # if the z component of a×b < 0, it is clockwise.
    clockwiseness * atand(norm(axb), dot(a, b))
end


function leftorright(θ)
    abst = abs(θ)
    if isapprox(abst, 90.0)
        return :center
    elseif 0.0 ≤ abst < 90.0
        return :left
    elseif 180.0 ≥ abst > 90.0
        return :right
    end
end

function bottomortop(θ)
    sgnt = sign(θ)
    if isapprox(sgnt, 0.0) || isapprox(abs(θ), 180.0)
        return :center
    elseif sgnt > 0
        return :bottom
    elseif sgnt < 0
        return :top
    end

end
