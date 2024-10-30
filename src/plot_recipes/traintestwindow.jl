
"""
```
mutable struct TwoHBoxes
    left::Int
    middle::Int
    right::Int
    unit
    label::String
    offset::Union{Nothing, Int}
end
```
`left`, `middle`, and `right` are each the ordinal number for the left/right edges and the middle boundary for the stacked horizontal boxes. `unit` is the unit of these ordinal numbers.

See `TwoHStackedBoxes` and `twohstackedboxes`.
"""
mutable struct TwoHBoxes
    left::Int
    middle::Int
    right::Int
    unit
    label::String
    offset::Union{Nothing,Int}
end

"""
`TwoHBoxes(t_left::T, t_ref::TimeType, t_right::T, label::AbstractString) where T<:Period`, where `t_ref` is converted from time to integer (using `_time2int`), with a unit determined by `_time2unit`.

See also `_time2int`, `_time2unit`.
"""
function TwoHBoxes(t_left::Period, t_ref::TimeType, t_right::Period, label::AbstractString)
    middle = t_ref |> _time2int
    left = t_ref - t_left |> _time2int
    right = t_ref + t_right |> _time2int
    # DateTime(...) - DateTime(...) is always ::DateTime
    # Date(...) - Date(...) is always ::Date
    unit = _timeunit(t_ref)
    TwoHBoxes(left, middle, right, unit, label, nothing)
end

"""
`_time2int(dt::TimeType)` convert `dt` to integer.
If `dt::DateTime`, it returns integer of unit `Millisecond`.
"""
_time2int(dt::DateTime) = Dates.datetime2epochms(dt)

"""
If `dt::Date`, it returns integer of unit `Day`.
"""
_time2int(dt::Date) = Dates.date2epochdays(dt)

"""
`_int2time(int::Int, unit)`.
If `unit` is `Type{Millisecond}`, `_int2time` convert integer `int` to `DateTime` using `Dates.epochms2datetime`.
"""
_int2time(int::Int, unit::Type{Millisecond}) = Dates.epochms2datetime(int)

"""
If `unit` is `Type{Day}`, `_int2time` convert integer `int` to `Date` using `Dates.epochdays2date`.
"""
_int2time(int::Int, unit::Type{Day}) = Dates.epochdays2date(int)

"""
`_timeunit(dt::TimeType)`
If `dt::DateTime`, the unit (of epoch/ordinal integer) is returned as `Millisecond`.
"""
_timeunit(dt::DateTime) = Millisecond

"""
If `dt::Date`, the unit (of epoch/ordinal integer) is returned as `Day`.
"""
_timeunit(dt::Date) = Day

"""
Define `left::Period`, `middle::TimeType`, and `right::Period` of each `TwoHBoxes` for two-segment bar, and plot these bars aligned with x axis with each corresponds to y ticks of `1:length(TTMs)` using `twohstackedboxes(TTMs)` where `TTMs::Vector{<:TwoHBoxes}`.

# Example
```@example
using Dates, Makie
TTMs = [TwoHBoxes(Day(60), dt, Day(10), "Test \$i") for (i, dt) in enumerate(Date(2020,1,1):Month(1):Date(2021,1,1))]
f = Figure()
ax = Axis(f[:,:])
out = twohstackedboxes!(ax, TTMs)
out
```

Noted that `twohstackedboxes!` not only mutate `ax::Axis` but also mutate `TTM` in `TTMs`, where `left`, `middle`, `right` is shifted by `offset` if `unit` is `DateTime`, since the ordinal number of `Millisecond` for `DateTime` is too large that will make Makie's plot wrongly displayed without raising an error.

# See also
- This function is created referencing [Julia Data Science: A Makie recipe for a DataFrame](https://juliadatascience.io/recipe_df)

"""
@recipe(TwoHStackedBoxes, v) do scene
    Attributes(
        a="hello",
        color_left=:cyan2,
        color_right=:plum1,
        label_left="train",
        label_right="test",
        color_middle=:black,
        barwidth=0.5,
        # kwargs_left = [strokecolor = :black, strokewidth = 1], # you cannot have this kind of vector
        # kwargs_left = (strokecolor = :black, strokewidth = 1), # you cannot have a tuple as attributes, for  MethodError: no method matching getindex(::Attributes)
    )
end

# `Makie.Combined` is deprecated. See https://discourse.julialang.org/t/ann-makie-v0-20/106569/11?u=okatsn
function legendoftwobox!(figpos, twh::Makie.Plot{OkMakieToolkits.twohstackedboxes,Tuple{Vector{TwoHBoxes}}}; kwargs...)
    Legend(
        figpos,
        [PolyElement(; color=twh.color_left), PolyElement(; color=twh.color_right)],
        [twh.label_left, twh.label_right]; kwargs...)
end

function Makie.plot!(p::TwoHStackedBoxes{<:Tuple{AbstractVector{<:TwoHBoxes}}})
    TTMs = p[:v][]
    _offset!(TTMs)
    color_right = p[:color_right][]
    color_left = p[:color_left][]
    color_middle = p[:color_middle][]
    halfbarwidth = p[:barwidth][] * 0.5
    ys = 1:length(TTMs)
    for (TTM, y) in zip(TTMs, ys)
        polytrain = Point2f[
            (TTM.left, y - halfbarwidth),
            (TTM.middle, y - halfbarwidth),
            (TTM.middle, y + halfbarwidth),
            (TTM.left, y + halfbarwidth),
        ]
        polytest = Point2f[
            (TTM.middle, y - halfbarwidth),
            (TTM.right, y - halfbarwidth),
            (TTM.right, y + halfbarwidth),
            (TTM.middle, y + halfbarwidth),
        ]
        poly!(p, polytest, color=color_right)
        poly!(p, polytrain, color=color_left)
        # poly!(Circle(Point2f(TTM.middle, y), halfbarwidth); color = color_middle)
        scatter!(p, TTM.middle, y; color=color_middle)
    end

end

_offset!(v::Vector{<:TwoHBoxes}) = _offset!(v,
    only(unique([TTM.unit for TTM in v])),
    only(unique([TTM.offset for TTM in v])))

_offset!(v, unit, offset) = v # do nothing

function _offset!(v::Vector{<:TwoHBoxes}, ::Type{Millisecond}, offset) # do offset only when the unit is `Type{Millisecond}`.
    if isnothing(offset)
        x0 = minimum([TTM.left for TTM in v])
        @info "$x0"
        for TTM in v
            TTM.left = TTM.left - x0
            TTM.right = TTM.right - x0
            TTM.middle = TTM.middle - x0
            TTM.offset = x0
        end
    end
    v
end

function twohboxes2tx(v::Vector{<:TwoHBoxes})
    offset = only(unique([TTM.offset for TTM in v]))
    x0l = [TTM.left for TTM in v]
    x0m = [TTM.middle for TTM in v]
    x0r = [TTM.right for TTM in v]
    x0 = vcat(x0l, x0m, x0r) |> sort!
    unit = only(unique([TTM.unit for TTM in v]))

    x1 = [x0i + offset for x0i in x0]
    t1 = _int2time.(x1, Ref(unit))
    return t1, x0
end


function datetimeticks!(ax, v::Vector{<:TwoHBoxes}, args...; kwargs...)
    t1, x0 = twohboxes2tx(v)
    datetimeticks!(ax, t1, x0, args...; kwargs...)
end

function datetimeticks!(ax2, v::Vector{<:TwoHBoxes}, ::LetTicksAsIs; kwargs...)
    t1, x0 = twohboxes2tx(v)
    datetimeticks!(ax2, t1, x0, LetTicksAsIs(); kwargs...)
end

function setyticks!(ax, v::Vector{<:TwoHBoxes})
    labels = [THB.label for THB in v]
    ax.yticks = (eachindex(labels), labels)
end

# todo: make a colorbar method
