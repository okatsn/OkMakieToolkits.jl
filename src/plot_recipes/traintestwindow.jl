
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
_timeunit(dt::DateTime) = Millisecond
_timeunit(dt::Date) = Day


@recipe(TrainTestPhase, v) do scene
    Attributes(
        a = "hello",
        color_left = :red,
        color_right = :blue,
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
    end

end

_offset!(v::Vector{<:TrainTestMarker}) = _offset!(v, only(unique([TTM.unit for TTM in v])))

_offset!(v, unit) = v # do nothing

function _offset!(v::Vector{<:TrainTestMarker}, ::Type{Millisecond})
    x0 = minimum([TTM.left for TTM in v])
    @info "$x0"
    for TTM in v
        TTM.left = TTM.left - x0
        TTM.right = TTM.right - x0
        TTM.middle = TTM.middle - x0
        TTM.offset = x0
    end
    v
end

# todo: make a colorbar method
