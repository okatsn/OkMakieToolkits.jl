struct ContinuousLineSegments
    table::DataFrame
    orderkey
    valuekeys::Tuple
    otherkeys
    function ContinuousLineSegments(df::AbstractDataFrame, orderkey, valuekeys; otherkeys = [])
        # orderkey = "time (ms)"
        rlag(x) = lag(x, -1)

        allkeys = vcat(orderkey, valuekeys..., otherkeys...)
        alltypes = [eltype(df[!, k]) for k in allkeys]

        df1 = @chain df begin
            select(orderkey,
                    collect(valuekeys) .=> rlag => x ->     "$(x)_1",
                    collect(valuekeys) .=> identity => x -> "$(x)_0",
                    collect(otherkeys) .=> rlag => x -> "$(x)_1",
                    collect(otherkeys) .=> identity => x -> "$(x)_0",
                    )
            stack(Not(orderkey))
            select(Not(:variable),
                    :variable => ByRow(x -> first(rsplit(x, "_"; limit = 2))) => :variable,
                    :variable => ByRow(x ->  last(rsplit(x, "_"; limit = 2))) => :shifted)
            sort(:shifted)
            sort(orderkey)
            groupby(:variable)
            combine(All())
            unstack
        end

        select!(df1, [k => (v -> convert(Vector{tp}, v)) for (k, tp) in zip(allkeys, alltypes)]...;
                renamecols = false)

        return new(df1[1:nrow(df1)-2, :], # the last row is missing in all valuekeys due to rlag.
                    orderkey,
                    valuekeys,
                    otherkeys)
    end
end

function OkMakieToolkits.linesegments!(ax::Axis, CLS::ContinuousLineSegments; kwargs...)
    # df = CLS.table;
    args = [CLS.table[!, k] for k in CLS.valuekeys]
    linesegments!(ax, args...;kwargs...)
    if length(CLS.valuekeys) == 2
        ax.xlabel[], ax.ylabel[] = string.(CLS.valuekeys)
    end
end
