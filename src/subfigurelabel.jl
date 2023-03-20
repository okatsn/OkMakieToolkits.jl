# See this for how to write an iterator:
# https://docs.julialang.org/en/v1/manual/interfaces/
struct SubfigureLabel
    count::Int
end

function Base.iterate(SL::SubfigureLabel, state=1)
    if SL.count > 26
        error("Sub-figure labels more than 26 is not supported.")
    end

    alllabels = 'a':'z'
    if state > SL.count
        out = nothing
    else
        out = ("($(alllabels[state]))", state+1)
    end
    return out
end

Base.length(SL::SubfigureLabel) = SL.count
