"""
```julia
struct PredictData{T<:Real}
    pred::T
    real::T
    fold::Int
end
```
"""
struct PredictData{T<:Real}
    pred::T
    real::T
    fold::Int
end

"""
An object that binds real data and predictions.

`PredictData(pred, real) = PredictData(pred, real, 0)`
"""
PredictData(pred, real) = PredictData(pred, real, 0)

"""
This is an experimental plot function of `timeseriesplot`.
It takes `x::AbstractVector{<:Real}` and `values::AbstractVector{<:PredictData}`, where
- `x` and `values` automatically become `Observable` inside the `plot!` function due to Makie's magic.
- additional `Observable`s should be defined if you want the plot to be updated on the change of data.
- In this recipe, we do not define color of lines/scatters as `Observable` that color won't update.

# Example
```julia
f = Figure();
timeseriesplot(f[1,1], x, values; testcolor=:brown2, realcolor=:blue, markersize=3)
# or
ax = Axis(f[1,2])
timeseriesplot!(ax, x, values)
# or
(f, ax, p) = timeseriesplot(TX.x[(firsttrain+1):end], [OT...])
```



# See also
- This function is created referencing [Example: Stock Chart](https://docs.makie.org/stable/documentation/recipes/#example_stock_chart)
- You may see [The recipe of raincloud](https://github.com/MakieOrg/Makie.jl/blob/eccef83e4b95f4211357c49357a1a6324be680b0/src/basic_recipes/raincloud.jl) for a more advanced utility of recipe. Noted that they use `@recipe(RainClouds, category_labels, data_array) do scene`, not just `@recipe(RainClouds) do scene`

"""
@recipe(TimeSeriesPlot) do scene
    Attributes(
        testcolor=:brown2,
        realcolor=:blue,
        markersize=4,
        marker='•',
    )
end

# It is more comprehensive to have `function Makie.plot!` rather than `function OkMakieToolkits.plot!`, since the connotation of `plot!` here is exactly `Makie.plot!`. Anyway, `function OkMakieToolkits.plot!` also works fine.
function Makie.plot!(TTC::TimeSeriesPlot{<:Tuple{AbstractVector{<:Real},AbstractVector{<:PredictData}}})
    times = TTC[1]
    soa = TTC[2]
    pred = Observable(Float64[])
    real = Observable(Float64[])

    function update_plot(times, soa)
        # clear the vectors inside the observables
        empty!(pred[])
        empty!(real[])

        for (t, pd) in zip(times, soa)
            push!(pred[], pd.pred)
            push!(real[], pd.real)
        end
    end

    # connect `update_plot` so that it is called whenever `times`
    # or `stockvalues` change
    Makie.Observables.onany(update_plot, times, soa)

    # then call it once manually with the first `times` and `stockvalues`
    # contents so we prepopulate all observables with correct values
    update_plot(times[], soa[])

    # vspan!
    lines!(TTC, times, real; color=TTC.realcolor, label="data")
    scatter!(TTC, times, pred;
        color=TTC.testcolor,
        markersize=TTC.markersize, label="predict", marker=TTC.marker)

    TTC

    # x0x1 = extrema(TX.x[tst])

    # vspan!(axt, x0x1...; color = colors_nfold(i))
    # text!(axt, formatnfold(i); color = :white, position=(mean(x0x1), maxy), align=(:center, :top), rotation= 0.1π, textsize=15)


end


"""
Referencing: https://docs.makie.org/stable/examples/blocks/legend/index.html#creating_legend_entries_manually
"""
function get_plot_elements(p::Combined{OkMakieToolkits.timeseriesplot,<:Any})
    @info "load successful"
    elem_real = LineElement(color=p.realcolor, linestyle=nothing)
    elem_test = MarkerElement(color=p.testcolor, marker=p.marker)
    return ([elem_real, elem_test], ["data", "prediction"])

end
