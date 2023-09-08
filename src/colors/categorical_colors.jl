
"""
`categorical_colors(args...; kwargs...)` creates a vector of colors of `RGBA <: Colorant` with by-default `alpha=1.0`; it takes the same `args` and `kwargs` as `Makie.cgrad`.

# Example
```julia
OkMakieToolkits.categorical_colors(:Set1_4, 4; alpha = 0.5)
```

- This function is intended for how to generate categorical colors using `cgrad` and may be deprecated in the future.
- `Makie.categorical_colors` does similar jobs, but does not support keyword argument such as `alpha`.
- `Makie.categorical_colors` and `OkMakieToolkits.categorical_colors` might return different color vector, for example:
  - `OkMakieToolkits.categorical_colors(:tab20, 15)`
  - `Makie.categorical_colors(:tab20, 15)`

"""
function categorical_colors(args...; alpha=1.0, kwargs...) # alpha is required and it overwrite the ones in kwargs.
    colorgrad = Makie.cgrad(args...; categorical=true, alpha=alpha, kwargs...) # to avoid `ERROR: ArgumentError: range(0.0, stop=1.0, length=1): endpoints differ` when the length of colors is 1
    return identity.(colorgrad.colors) # See  Makie.wong_colors |> methods
end
