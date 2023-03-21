var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = OkMakieToolkits","category":"page"},{"location":"#OkMakieToolkits","page":"Home","title":"OkMakieToolkits","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for OkMakieToolkits.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [OkMakieToolkits]","category":"page"},{"location":"#OkMakieToolkits.PairedCircleGenerator","page":"Home","title":"OkMakieToolkits.PairedCircleGenerator","text":"PairedCircleGenerator(outer_radius, linewidth) returns a pair of functions, solid and hollow, which generates solid and hollow circle of the same outer radius.\n\nExample\n\nPCG = PairedCircleGenerator(80, 1)\nmksz = [1,2,3]\nmksz2 = [0.8,1.7,2.5]\nscatter!(...; markersize = mksz, marker = PCG.solid.(mksz))\nscatter!(...; markersize = mksz2, marker = PCG.hollow.(mksz2))\n\n\n\n\n\n","category":"type"},{"location":"#OkMakieToolkits.PredictData","page":"Home","title":"OkMakieToolkits.PredictData","text":"struct PredictData{T<:Real}\n    pred::T\n    real::T\n    fold::Int\nend\n\n\n\n\n\n","category":"type"},{"location":"#OkMakieToolkits.PredictData-Tuple{Any, Any}","page":"Home","title":"OkMakieToolkits.PredictData","text":"An object that binds real data and predictions.\n\nPredictData(pred, real) = PredictData(pred, real, 0)\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.RangedTimeAsX","page":"Home","title":"OkMakieToolkits.RangedTimeAsX","text":"struct RangedTimeAsX     x::AbstractRange     t::StepRange     dx::Int     dt::TimePeriod end\n\nSimilar as TimeAsX, but RangedTimeAsX guarantee the step size to be uniform.\n\n\n\n\n\n","category":"type"},{"location":"#OkMakieToolkits.RangedTimeAsX-Tuple{AbstractRange, StepRange}","page":"Home","title":"OkMakieToolkits.RangedTimeAsX","text":"RangedTimeAsX(x::AbstractRange, t::StepRange). Error will occur if x, t are not of the same length.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.RangedTimeAsX-Tuple{TimeAsX}","page":"Home","title":"OkMakieToolkits.RangedTimeAsX","text":"RangedTimeAsX(TX::TimeAsX) convert a TimeAsX object to RangedTimeAsX if possible.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.RangedTimeAsX-Tuple{Vector{<:Int64}, Vector{<:Dates.DateTime}}","page":"Home","title":"OkMakieToolkits.RangedTimeAsX","text":"RangedTimeAsX(x::Vector{<:Int}, t::Vector{<:DateTime}).\n\nError will occur if x and t can not be converted to ranges of uniform step.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.TimeAsX","page":"Home","title":"OkMakieToolkits.TimeAsX","text":"TimeAsX(x, t; check_approxid = false) bind Integer indices to a DateTime array of the same size.\n\nExample\n\nt = DateTime(2018,1,1):Day(1):DateTime(2018,1,10)\nx = 5:14\nTX = TimeAsX(x, t)\nTX[1]\n\nTimeAsX([5], [DateTime(\"2018-01-01T00:00:00\")])\n\nIf check_approxid = true, it checks whether dx/dt is approximately identical anywhere.\n\n\n\n\n\n","category":"type"},{"location":"#OkMakieToolkits.TimeAsX-Tuple{Any}","page":"Home","title":"OkMakieToolkits.TimeAsX","text":"Example\n\nt = DateTime(2018,1,1):Day(1):DateTime(2018,1,10)\nTX = TimeAsX(t)\n\n\n\n\n\n","category":"method"},{"location":"#Makie.linkaxes!-Tuple{Makie.Figure}","page":"Home","title":"Makie.linkaxes!","text":"Given a figure, link all axes in f.content ([... for ax in f.content if ax isa Axis]).\n\nInspired by this reply\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.approxid-Tuple{Any, Any}","page":"Home","title":"OkMakieToolkits.approxid","text":"approxid(a, b) returns a if a and b are approximately identical. It passes keyword arguments to isapprox.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.blankaxis!-Union{Tuple{T}, Tuple{Any, T, T, T, T}} where T<:AbstractFloat","page":"Home","title":"OkMakieToolkits.blankaxis!","text":"blankaxis!(fpos, xmin::T, ymin::T, xmax::T, ymax::T) where {T<:AbstractFloat} creates an empty Makie Axis object at grid position fpos.\n\nExample\n\nf = Figure(;resolution=(1400,1000))\ngleft = f[1:3, 1] = GridLayout()\ngright = f[1:3, 2:3] = GridLayout()\nfpos = gright[0, :]\nblankaxis!(fpos, xmin, ymin, xmax, ymax)\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.circle_inner-Tuple{Any, Any, Any}","page":"Home","title":"OkMakieToolkits.circle_inner","text":"circle_inner(outer_radius,linewidth,markersize) creates the inner circle as a vector of points, where the linewidth is scaled by markersize.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.circle_outer-Tuple{Any}","page":"Home","title":"OkMakieToolkits.circle_outer","text":"circle_outer(outer_radius) creates a circle as a vector of points.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.datetimeticks!-Tuple{Any, TimeAsX, Dates.DatePeriod}","page":"Home","title":"OkMakieToolkits.datetimeticks!","text":"datetimeticks!(ax2, DTX::TimeAsX, tinc::DatePeriod; kwargs...). See TimeAsX\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.datetimeticks!-Tuple{Any, TimeAsX}","page":"Home","title":"OkMakieToolkits.datetimeticks!","text":"datetimeticks!(ax2, DTX::TimeAsX; kwargs...). See TimeAsX\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.datetimeticks!-Tuple{Any, Vector{Dates.DateTime}, Vector, Dates.DatePeriod}","page":"Home","title":"OkMakieToolkits.datetimeticks!","text":"Similar to datetimeticks!(ax2, t::Vector{DateTime}, x_a::Vector), datetimeticks!(ax2, t::Vector{DateTime}, x_a::Vector, tinc::DatePeriod; datestrformat = \"yyyy/mm/dd\", modify_fn = identity) return xticks, xticklabels with xticks forced to increase with step tinc, and be modify by function modify_fn.\n\nExample\n\ndatetimeticks!(\n    ax2,\n    [DateTime(2012,2,5,3,15,0), DateTime(2012,3,5,3,15,0)],\n    [0, 1], # `x` for `Makie.plot(x, ...)`\n    Day(3); # tick every 3 days\n    datestrformat = \"yyyy/mm/dd\",\n    modify_fn = x -> floor.(x, Day)\n)\n\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.datetimeticks!-Tuple{Any, Vector{Dates.DateTime}, Vector}","page":"Home","title":"OkMakieToolkits.datetimeticks!","text":"datetimeticks!(ax2, t::Vector{DateTime}, x::Vector; datestrformat = \"yyyy/mm/dd\") set x ticks to datestr format. t is the DateTime array that is not supported by Makie, x is a arbitrarily defined series of numbers that corresponds to t for Makie.plot. x and t must be the same length and should be pairwisely mapped.\n\nExample:\n\nt = df.datetime\nx = Dates.datetime2epochms.(t)\nx1 = x .- x[1] # to avoid glitchs in plotting with CairoMakie (due to the too-large values)\ny = df.soil_water\nCairoMakie.scatter!(ax, x, y, markersize =3)\ndatetimeticks!(ax2, t,x)\n\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.expandxylim!-NTuple{5, Any}","page":"Home","title":"OkMakieToolkits.expandxylim!","text":"expandxylim!(ax, upper_expand_x, lower_expand_x, lower_expand_y, upper_expand_y) TODO: merge with expandylim! in makietools.jl\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.expandylim!-Tuple{Any, Any}","page":"Home","title":"OkMakieToolkits.expandylim!","text":"expandylim!(ax, upper_expand) expand the upper limit of y axis to a ratio of upper_expand of the original y range (ymax - ymin).\n\nExample\n\nexpandylim!(ax, 0.25)\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.get_plot_elements-Tuple{MakieCore.Combined{OkMakieToolkits.timeseriesplot}}","page":"Home","title":"OkMakieToolkits.get_plot_elements","text":"Referencing: https://docs.makie.org/stable/examples/blocks/legend/index.html#creatinglegendentries_manually\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.getlimits-Tuple{Makie.Axis, Any}","page":"Home","title":"OkMakieToolkits.getlimits","text":"getlimits(ax::Axis, dim) returns the finallimits[] of dimension dim.\n\nExample\n\n(x0, x1) = convert.(Float64, getlimits(ax::Axis, 1))\n(y0, y1) = convert.(Float64, getlimits(ax::Axis, 2))\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.getxylimits-Tuple{Any}","page":"Home","title":"OkMakieToolkits.getxylimits","text":"Example\n\nxmin, ymin, xmax, ymax = getxylimits(ax)\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.mkgen_hollow-Tuple{Number}","page":"Home","title":"OkMakieToolkits.mkgen_hollow","text":"mkgen_hollow(markersize::Number; linewidth=1, outer_radius=80) generates hollow circle as a Polygon, which can be used for the marker kwarg of scatter!.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.mkgen_solid-Tuple{}","page":"Home","title":"OkMakieToolkits.mkgen_solid","text":"mkgen_solid(;outer_radius=80) generates solid circle as a Polygon, which can be used for the marker kwarg of scatter!.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.secondyaxis-Tuple{Any}","page":"Home","title":"OkMakieToolkits.secondyaxis","text":"secondyaxis(f_grid; color = :black, ylabel = \"y\") returns an Axis object of y axis to the right-hand side, with default settings for yyplot.\n\nExample\n\nf = Figure()\nax_right = secondyaxis(f[1,1]; color=:red)\n\n\n\nthat you can do lines!(ax_right, ...)\n\nFurther reading\n\nIs it possible to add a secondary y axis?\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.shrinkylim!-Tuple{Any, Vector{<:Number}}","page":"Home","title":"OkMakieToolkits.shrinkylim!","text":"shrinkylim!(ax, ydatas::Vector{<:Number}; extent = 0.15) fit y-limits to the input ydatas to with a certain extent.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.timeseriesplot!-Tuple","page":"Home","title":"OkMakieToolkits.timeseriesplot!","text":"This is an experimental plot function of timeseriesplot. It takes x::AbstractVector{<:Real} and values::AbstractVector{<:PredictData}, where\n\nx and values automatically become Observable inside the plot! function due to Makie's magic.\nadditional Observables should be defined if you want the plot to be updated on the change of data.\nIn this recipe, we do not define color of lines/scatters as Observable that color won't update.\n\nExample\n\nf = Figure();\ntimeseriesplot(f[1,1], x, values; testcolor=:brown2, realcolor=:blue, markersize=3)\n# or\nax = Axis(f[1,2])\ntimeseriesplot!(ax, x, values)\n# or\n(f, ax, p) = timeseriesplot(TX.x[(firsttrain+1):end], [OT...])\n\nSee also\n\nThis function is created referencing Example: Stock Chart\nYou may see The recipe of raincloud for a more advanced utility of recipe. Noted that they use @recipe(RainClouds, category_labels, data_array) do scene, not just @recipe(RainClouds) do scene\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.timeseriesplot-Tuple","page":"Home","title":"OkMakieToolkits.timeseriesplot","text":"This is an experimental plot function of timeseriesplot. It takes x::AbstractVector{<:Real} and values::AbstractVector{<:PredictData}, where\n\nx and values automatically become Observable inside the plot! function due to Makie's magic.\nadditional Observables should be defined if you want the plot to be updated on the change of data.\nIn this recipe, we do not define color of lines/scatters as Observable that color won't update.\n\nExample\n\nf = Figure();\ntimeseriesplot(f[1,1], x, values; testcolor=:brown2, realcolor=:blue, markersize=3)\n# or\nax = Axis(f[1,2])\ntimeseriesplot!(ax, x, values)\n# or\n(f, ax, p) = timeseriesplot(TX.x[(firsttrain+1):end], [OT...])\n\nSee also\n\nThis function is created referencing Example: Stock Chart\nYou may see The recipe of raincloud for a more advanced utility of recipe. Noted that they use @recipe(RainClouds, category_labels, data_array) do scene, not just @recipe(RainClouds) do scene\n\n\n\n\n\n","category":"method"}]
}