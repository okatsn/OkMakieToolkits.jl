struct ContinuousLineSegments
    table::DataFrame
    orderkey
    valuekeys
    function ContinuousLineSegments(df::AbstractDataFrame, orderkey, valuekeys)
        # orderkey = "time (ms)"
        # valuekeys = [:SEP, :FIM]
        rlag(x) = lag(x, -1)
        df1 = @chain df begin
            select(orderkey => :order,
                    valuekeys .=> rlag => x ->     "$(x)_1",
                    valuekeys .=> identity => x -> "$(x)_0",
                    )
            stack(Not(:order))
            select(Not(:variable),
                    :variable => ByRow(x -> first(rsplit(x, "_"; limit = 2))) => :variable,
                    :variable => ByRow(x ->  last(rsplit(x, "_"; limit = 2))) => :shifted)
            sort(:shifted)
            sort(:order)
            groupby(:variable)
            combine(All())
            unstack
        end
        return new(df1[1:nrow(df1)-2, :], # the last row is missing in all valuekeys due to rlag.
                    orderkey,
                    valuekeys)
    end
end

function OkMakieToolkits.linesegments!(ax::Axis, CLS::ContinuousLineSegments; kwargs...)
    # df = CLS.table;
    args = [CLS.table[!, k] for k in CLS.valuekeys]
    linesegments!(ax, args...;kwargs...)
end
