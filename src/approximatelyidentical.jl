"""
`approxid(a, b)` returns `a` if `a` and `b` are approximately identical.
It passes keyword arguments to `isapprox`.
"""
function approxid(a, b; kwargs...)
    @assert isapprox(a, b; kwargs...) "The two argument is not approximately identical."
    return a
end


function approxid(a::TimePeriod, b::TimePeriod; kwargs...)
    @assert isapprox(a.value, b.value; kwargs...) "The two argument is not approximately identical."
    return a
end
