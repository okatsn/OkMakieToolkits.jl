# TODO: consider a struct TimeAsX that binds t::DateTime with x::Vector{Integer}
"""
`TimeAsX` bind Integer indices to a `DateTime` array of the same size.
"""
struct TimeAsX
    x::Vector{<:Int}
    t::Vector{<:DateTime}
    function TimeAsX(x, t)
        @assert isequal(length(t), length(x)) "x and t in TimeAsX(x, t) must be equal in length."
        new(x, t)
    end
end

function TimeAsX(x, t::StepRange)
    t = collect(t)
    TimeAsX(x, t)
end

function TimeAsX(t)
    x = eachindex(t) |> collect
    TimeAsX(x, t)
end

function OkMakieToolkits.getindex(TX::TimeAsX, ind)
    TimeAsX(TX.x[ind], TX.t[ind])
end

"""
`datetimeticks!(ax2, t::Vector{DateTime}, x::Vector; datestrformat = "yyyy/mm/dd")` set x ticks to datestr format. `t` is the `DateTime` array that is not supported by Makie, `x` is a arbitrarily defined series of numbers that corresponds to `t` for `Makie.plot`. `x` and `t` must be the same length and should be pairwisely mapped.

# Example:
```julia
t = df.datetime
x = Dates.datetime2epochms.(t)
x1 = x .- x[1] # to avoid glitchs in plotting with CairoMakie (due to the too-large values)
y = df.soil_water
CairoMakie.scatter!(ax, x, y, markersize =3)
datetimeticks!(ax2, t,x)

```

"""
function datetimeticks!(ax2, t::Vector{DateTime}, x_a::Vector; datestrformat = "yyyy/mm/dd")
    t0, t1, t10, x0, x1, x10 = _datetimetick0(t, x_a)

    dateticks = optimize_ticks(extrema(t)...)[1]
    # PlotUtils.optimize_ticks(t0::DateTime, t1::DateTime) don't apply kwargs such as `k_min` and `k_max` in the function even when the kwarg is supported. See the source code.
    xticks, xticklabels = ticklabelconvert(t0, t1, t10, x0, x1, x10, dateticks, datestrformat)

    ax2.xticks[] = (xticks, xticklabels)
    return xticks, xticklabels
end

"""
Similar to `datetimeticks!(ax2, t::Vector{DateTime}, x_a::Vector)`, `datetimeticks!(ax2, t::Vector{DateTime}, x_a::Vector, tinc::DatePeriod; datestrformat = "yyyy/mm/dd", modify_fn = identity)` return `xticks, xticklabels` with `xticks` forced to increase with step `tinc`, and be modify by function `modify_fn`.

# Example
```julia
datetimeticks!(
    ax2,
    [DateTime(2012,2,5,3,15,0), DateTime(2012,3,5,3,15,0)],
    [0, 1], # `x` for `Makie.plot(x, ...)`
    Day(3); # tick every 3 days
    datestrformat = "yyyy/mm/dd",
    modify_fn = x -> floor.(x, Day)
)

```

"""
function datetimeticks!(ax2, t::Vector{DateTime}, x_a::Vector, tinc::DatePeriod; datestrformat = "yyyy/mm/dd", modify_fn = identity)
    t0, t1, t10, x0, x1, x10 = _datetimetick0(t, x_a)
    dateticks = range(t0, t1, step=tinc) |> collect
    dateticks = modify_fn(dateticks)

    xticks, xticklabels = ticklabelconvert(t0, t1, t10, x0, x1, x10, dateticks, datestrformat)

    ax2.xticks[] = (xticks, xticklabels)
end

function ticklabelconvert(t0, t1, t10, x0, x1, x10, dateticks, datestrformat)
    xticks = ((dateticks .- t0) ./ t10) .* x10 .+ x0
    xticklabels = Dates.format.(dateticks, datestrformat)
    return xticks, xticklabels

end


function _datetimetick0(t, x_a)
    if length(t) != length(x_a)
        error("t and x should be the same length.")
    end

    t0, t1 = extrema(t)
    x0, x1 = extrema(x_a)
    t10 = t1 -t0
    x10 = x1 -x0
    # t0, t1 = map(f -> f(t), [minimum, maximum])
    # t10 = t1 -t0
    # x0, x1 = map(f -> f(x_a), [minimum, maximum])
    # x10 = x1 -x0

    return t0, t1, t10, x0, x1, x10
end

"""
`datetimeticks!(ax2, DTX::TimeAsX; kwargs...)`. See `TimeAsX`
"""
function datetimeticks!(ax2, DTX::TimeAsX; kwargs...)
    datetimeticks!(ax2, DTX.t, DTX.x; kwargs...)
end
