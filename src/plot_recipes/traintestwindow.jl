
mutable struct TrainTestMarker
    left::Int
    middle::Int
    right::Int
    unit
    label::String
    offset::Union{Nothing, Int}
end

function TrainTestMarker(train::T, ref::TimeType, test::T, label::AbstractString) where T<:Period
    middle = ref        |> _time2int
    left = ref - train  |> _time2int
    right = ref + test  |> _time2int
    # DateTime(...) - DateTime(...) is always ::DateTime
    # Date(...) - Date(...) is always ::Date
    unit = _timeunit(ref)
    TrainTestMarker(left, middle, right, unit, label, nothing)
end

_time2int(dt::DateTime) = Dates.datetime2epochms(dt)
_time2int(dt::Date) = Dates.date2epochdays(dt)
_int2time(int::Int, unit::Type{Millisecond}) = Dates.epochms2datetime(int)
_int2time(int::Int, unit::Type{Day}) = Dates.epochdays2date(int)
_timeunit(dt::DateTime) = Millisecond
_timeunit(dt::Date) = Day


@recipe(TrainTestPhase, v) do scene
    Attributes(
        a = "hello",
        color_left = :cyan2,
        color_right = :plum1,
        color_middle = :black,
        barwidth = 0.5,
        # kwargs_left = [strokecolor = :black, strokewidth = 1], # you cannot have this kind of vector
        # kwargs_left = (strokecolor = :black, strokewidth = 1), # you cannot have a tuple as attributes, for  MethodError: no method matching getindex(::Attributes)
    )
end

function CairoMakie.plot!(p::TrainTestPhase{<:Tuple{AbstractVector{<:TrainTestMarker}}})
    TTMs = p[:v][]
    _offset!(TTMs)
    color_right = p[:color_right][]
    color_left = p[:color_left][]
    color_middle = p[:color_middle][]
    halfbarwidth = p[:barwidth][] * 0.5
    ys = 1:length(TTMs)
    for (TTM,y) in zip(TTMs, ys)
        polytrain = Point2f[
            (TTM.left,   y - halfbarwidth),
            (TTM.middle, y - halfbarwidth),
            (TTM.middle, y + halfbarwidth),
            (TTM.left,   y + halfbarwidth),
        ]
        polytest = Point2f[
            (TTM.middle, y - halfbarwidth),
            (TTM.right,  y - halfbarwidth),
            (TTM.right,  y + halfbarwidth),
            (TTM.middle, y + halfbarwidth),
        ]
        poly!(polytest , color = color_right)
        poly!(polytrain, color = color_left)
        # poly!(Circle(Point2f(TTM.middle, y), halfbarwidth); color = color_middle)
        scatter!(TTM.middle, y; color = color_middle)
    end

end

_offset!(v::Vector{<:TrainTestMarker}) = _offset!(v,
    only(unique([TTM.unit for TTM in v])),
    only(unique([TTM.offset for TTM in v])))

_offset!(v, unit) = v # do nothing

function _offset!(v::Vector{<:TrainTestMarker}, ::Type{Millisecond}, offset)
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

function datetimeticks!(ax, v::Vector{<:TrainTestMarker}; kwargs...)
    offset = only(unique([TTM.offset for TTM in v]))
    x0 = [TTM.left for TTM in v]
    unit = only(unique([TTM.unit for TTM in v]))

    x1 = [TTM.left + offset for TTM in v]
    t1 = _int2time.(x1, Ref(unit))
    datetimeticks!(ax, t1, x0; kwargs...)
end

# todo: make a colorbar method
