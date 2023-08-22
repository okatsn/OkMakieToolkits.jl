
"""
`TimeAsX(x, t; check_approxid = false)` bind Integer indices to a `DateTime` array of the same size.

# Example
```julia
t = DateTime(2018,1,1):Day(1):DateTime(2018,1,10)
x = 5:14
TX = TimeAsX(x, t)
TX[1]
```

```julia-repl
TimeAsX([5], [DateTime("2018-01-01T00:00:00")])
```

If `check_approxid = true`, it checks whether dx/dt is approximately identical anywhere.

"""
struct TimeAsX
    x::Vector{<:Int}
    t::Vector{<:DateTime}
    function TimeAsX(x, t; check_approxid=false)
        if check_approxid
            dxdt = diff(x) ./ [dt.value for dt in diff(t)]
            reduce(approxid, dxdt) # Check if dxdt is always (approximately) identical.
        end
        @assert isequal(length(t), length(x)) "x and t in TimeAsX(x, t) must be equal in length."
        new(x, t)
    end
end


# struct DurationTimeAsX
#     dx::Int
#     dt::TimePeriod
#     function DurationTimeAsX(x, t)
#         @assert isequal(length(t), length(x)) "x and t in TimeAsX(x, t) must be equal in length."
#         new(x, t)
#     end
# end

function TimeAsX(x, t::StepRange)
    t = collect(t)
    TimeAsX(x, t)
end

function TimeAsX(x::AbstractRange, t)
    x = collect(x)
    TimeAsX(x, t)
end

function TimeAsX(x::AbstractRange, t::StepRange)
    TimeAsX(collect(x), collect(t))
end

function TimeAsX(x::Number, t::DateTime)
    TimeAsX([x], [t])
end

## Extending Base functions for TimeAsX

"""
# Example
```julia
t = DateTime(2018,1,1):Day(1):DateTime(2018,1,10)
TX = TimeAsX(t)
```
"""
function TimeAsX(t)
    x = eachindex(t) |> collect
    TimeAsX(x, t)
end

function OkMakieToolkits.getindex(TX::TimeAsX, ind)
    TimeAsX(TX.x[ind], TX.t[ind])
end


# function OkMakieToolkits.show(io, TX::TimeAsX)
#     todo: a clean/concise demonstration of the output?
# end


"""
struct RangedTimeAsX
    x::AbstractRange
    t::StepRange
    dx::Int
    dt::TimePeriod
end

Similar as `TimeAsX`, but `RangedTimeAsX` guarantee the step size to be uniform.
"""
struct RangedTimeAsX
    x::AbstractRange
    t::StepRange
    dx::Int
    dt::TimePeriod
end

"""
`RangedTimeAsX(x::AbstractRange, t::StepRange)`.
Error will occur if `x`, `t` are not of the same length.
"""
function RangedTimeAsX(x::AbstractRange, t::StepRange)
    @assert isequal(length(t), length(x)) "x and t in RangedTimeAsX(x, t) must be equal in length."
    new(x, t, x[2] - x[1], t[2] - t[1])
end

"""
`RangedTimeAsX(x::Vector{<:Int}, t::Vector{<:DateTime})`.

Error will occur if `x` and `t` can not be converted to ranges of uniform step.
"""
function RangedTimeAsX(x::Vector{<:Int}, t::Vector{<:DateTime})
    dxs = diff(x)
    dts = diff(t)
    dx = reduce(approxid, dxs)
    dt = reduce(approxid, dts) # error will occurs if it is not equally spaced
    xr = range(first(x), last(x), step=dx)
    tr = range(first(t), last(t), step=dt)
    @assert all(isapprox.(x, xr))
    @assert all(isequal.(t, tr))
    RangedTimeAsX(xr, tr, dx, dt)
end

"""
`RangedTimeAsX(TX::TimeAsX)` convert a `TimeAsX` object to `RangedTimeAsX` if possible.
"""
function RangedTimeAsX(TX::TimeAsX)
    RangedTimeAsX(TX.x, TX.t)
end

"""
`datetimeticks!(ax2, t::Vector{DateTime}, x::Vector; datestrformat = "yyyy/mm/dd")` set x ticks to datestr format. `t` is the `DateTime` array that is not supported by Makie, `x` is a arbitrarily defined series of numbers that corresponds to `t` for `Makie.plot`. `x` and `t` must be the same length and should be pairwisely mapped.

# Example:
```julia
t = df.datetime
x = Dates.datetime2epochms.(t)
x1 = x .- x[1] # to avoid glitchs in plotting with Makie (due to the too-large values)
y = df.soil_water
Makie.scatter!(ax, x, y, markersize =3)
datetimeticks!(ax2, t,x)

```

"""
function datetimeticks!(ax2, t::Vector{DateTime}, x_a::Vector; datestrformat="yyyy/mm/dd")
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
function datetimeticks!(ax2, t::Vector{DateTime}, x_a::Vector, tinc::DatePeriod; datestrformat="yyyy/mm/dd", modify_fn=identity)
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
    t10 = t1 - t0
    x10 = x1 - x0
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

"""
`datetimeticks!(ax2, DTX::TimeAsX, tinc::DatePeriod; kwargs...)`. See `TimeAsX`
"""
function datetimeticks!(ax2, DTX::TimeAsX, tinc::DatePeriod; kwargs...)
    datetimeticks!(ax2, DTX.t, DTX.x, tinc; kwargs...)
end
