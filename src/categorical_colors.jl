
"""
`categorical_colors(args...; kwargs...)` creates a vector of colors of `RGBA` with by-default `alpha=1.0`; it takes the same `args` and `kwargs` as `CairoMakie.cgrad`.
"""
function categorical_colors(args...; alpha=1.0, kwargs...) # alpha is required and it overwrite the ones in kwargs.
    colorgrad = CairoMakie.cgrad(args...; categorical = true, kwargs...) # to avoid `ERROR: ArgumentError: range(0.0, stop=1.0, length=1): endpoints differ` when the length of colors is 1
    return identity.(colorgrad.colors) # See  Makie.wong_colors |> methods
end
