var documenterSearchIndex = {"docs":
[{"location":"colormap/#Understanding-colormap","page":"Colormap","title":"Understanding colormap","text":"","category":"section"},{"location":"colormap/","page":"Colormap","title":"Colormap","text":"Here is a cheat sheet modified from Colors/Cheat sheet of the documentation of Makie:","category":"page"},{"location":"colormap/","page":"Colormap","title":"Colormap","text":"using Makie\nusing Makie.Colors\n\ntheme = Attributes(\n    Scatter = (; markersize = 40),\n    Text = (; align = (:center, :bottom), offset = (0, 30))\n)\n\nwith_theme(theme) do\n\n    f = Figure(resolution = (800, 1300))\n    ax = Axis(f[1, 1], xautolimitmargin = (0.2, 0.2), yautolimitmargin = (0.1, 0.1))\n    hidedecorations!(ax)\n    hidespines!(ax)\n\n    scatter!(ax, 1, 1, color = :red)\n    text!(ax, 1, 1, text = \":red\")\n\n    scatter!(ax, 2, 1, color = (:red, 0.5))\n    text!(ax, 2, 1, text = \"(:red, 0.5)\")\n\n    scatter!(ax, 3, 1, color = RGBf(0.5, 0.2, 0.8))\n    text!(ax, 3, 1, text = \"RGBf(0.5, 0.2, 0.8)\")\n    \n    scatter!(ax, 4, 1, color = RGBAf(0.5, 0.2, 0.8, 0.5))\n    text!(ax, 4, 1, text = \"RGBAf(0.5, 0.2, 0.8, 0.5)\")\n\n    scatter!(ax, 1, 0, color = Colors.HSV(40, 30, 60))\n    text!(ax, 1, 0, text = \"Colors.HSV(40, 30, 60)\")\n\n    scatter!(ax, 2, 0, color = 1, colormap = :tab10, colorrange = (1, 10))\n    text!(ax, 2, 0, text = \"color = 1\\ncolormap = :tab10\\ncolorrange = (1, 10)\")\n\n    scatter!(ax, 3, 0, color = 2, colormap = :tab10, colorrange = (1, 10))\n    text!(ax, 3, 0, text = \"color = 2\\ncolormap = :tab10\\ncolorrange = (1, 10)\")\n\n    scatter!(ax, 4, 0, color = 3, colormap = :tab10, colorrange = (1, 10))\n    text!(ax, 4, 0, text = \"color = 3\\ncolormap = :tab10\\ncolorrange = (1, 10)\")\n\n    text!(ax, 2.5, -1, text = \"color = 1:10\\ncolormap = :viridis\\ncolorrange = automatic\")\n    scatter!(ax, range(1, 4, length = 10), fill(-1, 10), color = 1:10, colormap = :viridis)\n    \n    color_2 = [collect(1:9)..., 15]\n    text!(ax, 2.5, -2, text = \"color = $color_2\\ncolormap = :viridis\\ncolorrange = automatic\")\n    scatter!(ax, range(1, 4, length = 10), fill(-2, 10), color = color_2, colormap = cgrad(:viridis, 10))\n\n    text!(ax, 2.5, -3, text = \"color = [1, 2, 3, 4, NaN, 6, 7, 8, 9, 10]\\ncolormap = :viridis\\ncolorrange = (2, 9)\")\n    scatter!(ax, range(1, 4, length = 10), fill(-3, 10), color = [1, 2, 3, 4, NaN, 6, 7, 8, 9, 10], colormap = :viridis, colorrange = (2, 9))\n\n    text!(ax, 2.5, -4, text = \"color = [1, 2, 3, 4, NaN, 6, 7, 8, 9, 10]\\ncolormap = :viridis; colorrange = (2, 9)\\nnan_color = :red, highclip = :magenta, lowclip = :cyan\")\n    scatter!(ax, range(1, 4, length = 10), fill(-4, 10), color = [1, 2, 3, 4, NaN, 6, 7, 8, 9, 10], colormap = :viridis, colorrange = (2, 9), nan_color = :red, highclip = :magenta, lowclip = :cyan)\n    \n    text!(ax, 2.5, -5, text = \"color = HSV.(range(0, 360, 10), 50, 50)\")\n    scatter!(ax, range(1, 4, length = 10), fill(-5, 10), color = HSV.(range(0, 360, 10), 50, 50))\n\n    text!(ax, 2.5, -6, text = \"color = 1:10\\ncolormap = (:viridis, 0.5)\\ncolorrange = automatic\")\n    scatter!(ax, range(1, 4, length = 10), fill(-6, 10), color = 1:10, colormap = (:viridis, 0.5))\n\n    text!(ax, 2.5, -7, text = \"color = 1:10\\ncolormap = [:red, :orange, :brown]\\ncolorrange = automatic\")\n    scatter!(ax, range(1, 4, length = 10), fill(-7, 10), color = 1:10, colormap = [:red, :orange, :brown])\n    \n    text!(ax, 2.5, -8, text = \"color = 1:10\\ncolormap = Reverse(:viridis)\\ncolorrange = automatic\")\n    scatter!(ax, range(1, 4, length = 10), fill(-8, 10), color = 1:10, colormap = Reverse(:viridis))\n\n    color_rv = reverse(1:10)\n    text!(ax, 2.5, -9, text = \"color = $color_rv\\ncolormap = :viridis\\ncolorrange = automatic\")\n    scatter!(ax, range(1, 4, length = 10), fill(-9, 10), color = color_rv, colormap = :viridis)\n\n    f\nend","category":"page"},{"location":"colormap/","page":"Colormap","title":"Colormap","text":"Makie.cgrad(:viridis, 10)","category":"page"},{"location":"colormap/","page":"Colormap","title":"Colormap","text":"Key points:","category":"page"},{"location":"colormap/","page":"Colormap","title":"Colormap","text":"For categorical data, saying some integers, specify colorrange to the maximum/minimum of the data to make sure a color on the plot is exactly corresponded to a certain color. \nAs a out–of-colorrange data value has the same color as the nearest one in range, use lowclip and highclip to highlight the difference.","category":"page"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = OkMakieToolkits","category":"page"},{"location":"#OkMakieToolkits","page":"Home","title":"OkMakieToolkits","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for OkMakieToolkits.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [OkMakieToolkits]","category":"page"},{"location":"#OkMakieToolkits.PairedCircleGenerator","page":"Home","title":"OkMakieToolkits.PairedCircleGenerator","text":"PairedCircleGenerator(outer_radius, linewidth) returns a pair of functions, solid and hollow, which generates solid and hollow circle of the same outer radius.\n\nExample\n\nPCG = PairedCircleGenerator(80, 1)\nmksz = [1,2,3]\nmksz2 = [0.8,1.7,2.5]\nscatter!(...; markersize = mksz, marker = PCG.solid.(mksz))\nscatter!(...; markersize = mksz2, marker = PCG.hollow.(mksz2))\n\n\n\n\n\n","category":"type"},{"location":"#OkMakieToolkits.PredictData","page":"Home","title":"OkMakieToolkits.PredictData","text":"struct PredictData{T<:Real}\n    pred::T\n    real::T\n    fold::Int\nend\n\n\n\n\n\n","category":"type"},{"location":"#OkMakieToolkits.PredictData-Tuple{Any, Any}","page":"Home","title":"OkMakieToolkits.PredictData","text":"An object that binds real data and predictions.\n\nPredictData(pred, real) = PredictData(pred, real, 0)\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.RangedTimeAsX","page":"Home","title":"OkMakieToolkits.RangedTimeAsX","text":"struct RangedTimeAsX     x::AbstractRange     t::StepRange     dx::Int     dt::TimePeriod end\n\nSimilar as TimeAsX, but RangedTimeAsX guarantee the step size to be uniform.\n\n\n\n\n\n","category":"type"},{"location":"#OkMakieToolkits.RangedTimeAsX-Tuple{AbstractRange, StepRange}","page":"Home","title":"OkMakieToolkits.RangedTimeAsX","text":"RangedTimeAsX(x::AbstractRange, t::StepRange). Error will occur if x, t are not of the same length.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.RangedTimeAsX-Tuple{TimeAsX}","page":"Home","title":"OkMakieToolkits.RangedTimeAsX","text":"RangedTimeAsX(TX::TimeAsX) convert a TimeAsX object to RangedTimeAsX if possible.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.RangedTimeAsX-Tuple{Vector{<:Int64}, Vector{<:Dates.DateTime}}","page":"Home","title":"OkMakieToolkits.RangedTimeAsX","text":"RangedTimeAsX(x::Vector{<:Int}, t::Vector{<:DateTime}).\n\nError will occur if x and t can not be converted to ranges of uniform step.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.TimeAsX","page":"Home","title":"OkMakieToolkits.TimeAsX","text":"TimeAsX(x, t; check_approxid = false) bind Integer indices to a DateTime array of the same size.\n\nExample\n\nt = DateTime(2018,1,1):Day(1):DateTime(2018,1,10)\nx = 5:14\nTX = TimeAsX(x, t)\nTX[1]\n\nTimeAsX([5], [DateTime(\"2018-01-01T00:00:00\")])\n\nIf check_approxid = true, it checks whether dx/dt is approximately identical anywhere.\n\n\n\n\n\n","category":"type"},{"location":"#OkMakieToolkits.TimeAsX-Tuple{Any}","page":"Home","title":"OkMakieToolkits.TimeAsX","text":"Example\n\nt = DateTime(2018,1,1):Day(1):DateTime(2018,1,10)\nTX = TimeAsX(t)\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.TwoHBoxes","page":"Home","title":"OkMakieToolkits.TwoHBoxes","text":"mutable struct TwoHBoxes\n    left::Int\n    middle::Int\n    right::Int\n    unit\n    label::String\n    offset::Union{Nothing, Int}\nend\n\nleft, middle, and right are each the ordinal number for the left/right edges and the middle boundary for the stacked horizontal boxes. unit is the unit of these ordinal numbers.\n\nSee TwoHStackedBoxes and twohstackedboxes.\n\n\n\n\n\n","category":"type"},{"location":"#OkMakieToolkits.TwoHBoxes-Tuple{Dates.Period, Dates.TimeType, Dates.Period, AbstractString}","page":"Home","title":"OkMakieToolkits.TwoHBoxes","text":"TwoHBoxes(t_left::T, t_ref::TimeType, t_right::T, label::AbstractString) where T<:Period, where t_ref is converted from time to integer (using _time2int), with a unit determined by _time2unit.\n\nSee also _time2int, _time2unit.\n\n\n\n\n\n","category":"method"},{"location":"#Makie.linkaxes!-Tuple{Makie.Figure}","page":"Home","title":"Makie.linkaxes!","text":"Given a figure, link all axes in f.content ([... for ax in f.content if ax isa Axis]).\n\nExample\n\nusing Makie, OkMakieToolkits\nx = 1:10\ny1 = randn(10)\ny2 = 1 .+ 2 * randn(10)\nf = Figure()\nax1 = Axis(f[1, 1])\nax2 = Axis(f[1, 2])\nlines!(ax1, x, y1)\nscatter!(ax2, x, y2)\n\n# This assures figure is up-to-date and prevents potential changes on the limits of axes (e.g., slightly shift between linked axes).\nMakie.update_state_before_display!(f)\n\n# Call `Makie.linkaxis!(axs...)` for any `ax` on `f`.\nlinkaxes!(f) # equivalent to linkaxes!(ax1, ax2)\n\nInspired by this reply\n\nSee also OkMakieToolkits.linkxaxes!, OkMakieToolkits.linkyaxes!\n\n\n\n\n\n","category":"method"},{"location":"#Makie.linkxaxes!-Tuple{Makie.Figure}","page":"Home","title":"Makie.linkxaxes!","text":"See OkMakieToolkits.linkaxes!.\n\n\n\n\n\n","category":"method"},{"location":"#Makie.linkyaxes!-Tuple{Makie.Figure}","page":"Home","title":"Makie.linkyaxes!","text":"See OkMakieToolkits.linkaxes!.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits._int2time-Tuple{Int64, Type{Dates.Day}}","page":"Home","title":"OkMakieToolkits._int2time","text":"If unit is Type{Day}, _int2time convert integer int to Date using Dates.epochdays2date.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits._int2time-Tuple{Int64, Type{Dates.Millisecond}}","page":"Home","title":"OkMakieToolkits._int2time","text":"_int2time(int::Int, unit). If unit is Type{Millisecond}, _int2time convert integer int to DateTime using Dates.epochms2datetime.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits._time2int-Tuple{Dates.DateTime}","page":"Home","title":"OkMakieToolkits._time2int","text":"_time2int(dt::TimeType) convert dt to integer. If dt::DateTime, it returns integer of unit Millisecond.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits._time2int-Tuple{Dates.Date}","page":"Home","title":"OkMakieToolkits._time2int","text":"If dt::Date, it returns integer of unit Day.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits._timeunit-Tuple{Dates.DateTime}","page":"Home","title":"OkMakieToolkits._timeunit","text":"_timeunit(dt::TimeType) If dt::DateTime, the unit (of epoch/ordinal integer) is returned as Millisecond.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits._timeunit-Tuple{Dates.Date}","page":"Home","title":"OkMakieToolkits._timeunit","text":"If dt::Date, the unit (of epoch/ordinal integer) is returned as Day.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.approxid-Tuple{Any, Any}","page":"Home","title":"OkMakieToolkits.approxid","text":"approxid(a, b) returns a if a and b are approximately identical. It passes keyword arguments to isapprox.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.blankaxis!-Union{Tuple{T}, Tuple{Any, Vararg{T, 4}}} where T<:AbstractFloat","page":"Home","title":"OkMakieToolkits.blankaxis!","text":"blankaxis!(fpos, xmin::T, ymin::T, xmax::T, ymax::T) where {T<:AbstractFloat} creates an empty Makie Axis object at grid position fpos.\n\nExample\n\nf = Figure(;resolution=(1400,1000))\ngleft = f[1:3, 1] = GridLayout()\ngright = f[1:3, 2:3] = GridLayout()\nfpos = gright[0, :]\nblankaxis!(fpos, xmin, ymin, xmax, ymax)\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.categorical_colors-Tuple","page":"Home","title":"OkMakieToolkits.categorical_colors","text":"categorical_colors(args...; kwargs...) creates a vector of colors of RGBA <: Colorant with by-default alpha=1.0; it takes the same args and kwargs as Makie.cgrad.\n\nExample\n\nOkMakieToolkits.categorical_colors(:Set1_4, 4; alpha = 0.5)\n\nThis function is intended for how to generate categorical colors using cgrad and may be deprecated in the future.\nMakie.categorical_colors does similar jobs, but does not support keyword argument such as alpha.\nMakie.categorical_colors and OkMakieToolkits.categorical_colors might return different color vector, for example:\nOkMakieToolkits.categorical_colors(:tab20, 15)\nMakie.categorical_colors(:tab20, 15)\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.circle_inner-Tuple{Any, Any, Any}","page":"Home","title":"OkMakieToolkits.circle_inner","text":"circle_inner(outer_radius,linewidth,markersize) creates the inner circle as a vector of points, where the linewidth is scaled by markersize.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.circle_outer-Tuple{Any}","page":"Home","title":"OkMakieToolkits.circle_outer","text":"circle_outer(outer_radius) creates a circle as a vector of points.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.colrange-Tuple{Any}","page":"Home","title":"OkMakieToolkits.colrange","text":"colrange(block) returns the column range of the block (Axis).\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.datetimeticks!-Tuple{Any, TimeAsX, Dates.DatePeriod}","page":"Home","title":"OkMakieToolkits.datetimeticks!","text":"datetimeticks!(ax2, DTX::TimeAsX, tinc::DatePeriod; kwargs...). See TimeAsX\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.datetimeticks!-Tuple{Any, TimeAsX}","page":"Home","title":"OkMakieToolkits.datetimeticks!","text":"datetimeticks!(ax2, DTX::TimeAsX; kwargs...). See TimeAsX\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.datetimeticks!-Tuple{Any, Vector{Dates.DateTime}, Vector, Dates.DatePeriod}","page":"Home","title":"OkMakieToolkits.datetimeticks!","text":"Similar to datetimeticks!(ax2, t::Vector{DateTime}, x_a::Vector), datetimeticks!(ax2, t::Vector{DateTime}, x_a::Vector, tinc::DatePeriod; datestrformat = \"yyyy/mm/dd\", modify_fn = identity) return xticks, xticklabels with xticks forced to increase with step tinc, and be modify by function modify_fn.\n\nExample\n\ndatetimeticks!(\n    ax2,\n    [DateTime(2012,2,5,3,15,0), DateTime(2012,3,5,3,15,0)],\n    [0, 1], # `x` for `Makie.plot(x, ...)`\n    Day(3); # tick every 3 days\n    datestrformat = \"yyyy/mm/dd\",\n    modify_fn = x -> floor.(x, Day)\n)\n\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.datetimeticks!-Tuple{Any, Vector{Dates.DateTime}, Vector}","page":"Home","title":"OkMakieToolkits.datetimeticks!","text":"datetimeticks!(ax2, t::Vector{DateTime}, x::Vector; datestrformat = \"yyyy/mm/dd\") set x ticks to datestr format. t is the DateTime array that is not supported by Makie, x is a arbitrarily defined series of numbers that corresponds to t for Makie.plot. x and t must be the same length and should be pairwisely mapped.\n\nExample:\n\nt = df.datetime\nx = Dates.datetime2epochms.(t)\nx1 = x .- x[1] # to avoid glitchs in plotting with Makie (due to the too-large values)\ny = df.soil_water\nMakie.scatter!(ax, x, y, markersize =3)\ndatetimeticks!(ax2, t,x)\n\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.expandxylim!-NTuple{5, Any}","page":"Home","title":"OkMakieToolkits.expandxylim!","text":"expandxylim!(ax, upper_expand_x, lower_expand_x, lower_expand_y, upper_expand_y) TODO: merge with expandylim! in makietools.jl\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.expandylim!-Tuple{Any, Any}","page":"Home","title":"OkMakieToolkits.expandylim!","text":"expandylim!(ax, upper_expand) expand the upper limit of y axis to a ratio of upper_expand of the original y range (ymax - ymin).\n\nExample\n\nexpandylim!(ax, 0.25)\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.gadfly_default-Tuple{Any}","page":"Home","title":"OkMakieToolkits.gadfly_default","text":"gadfly_default(n) generate a vector of LCHab <: Colorant colors, which are default colors of Gadfly.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.get_plot_elements-Tuple{MakieCore.Combined{OkMakieToolkits.timeseriesplot}}","page":"Home","title":"OkMakieToolkits.get_plot_elements","text":"Referencing: https://docs.makie.org/stable/examples/blocks/legend/index.html#creatinglegendentries_manually\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.getlimits-Tuple{Makie.Axis, Any}","page":"Home","title":"OkMakieToolkits.getlimits","text":"getlimits(ax::Axis, dim) returns the finallimits[] of dimension dim.\n\nExample\n\n(x0, x1) = convert.(Float64, getlimits(ax::Axis, 1))\n(y0, y1) = convert.(Float64, getlimits(ax::Axis, 2))\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.getxylimits-Tuple{Any}","page":"Home","title":"OkMakieToolkits.getxylimits","text":"Example\n\nxmin, ymin, xmax, ymax = getxylimits(ax)\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.keeponlysamecollinked!-Tuple{Vector{Makie.Axis}}","page":"Home","title":"OkMakieToolkits.keeponlysamecollinked!","text":"keeponlysamecollinked!(axs::Vector{Axis}) keeps x-axis of each axs stay linked only to those axes of the same column range. It has the same effect as the followings:\n\naxs = filter(x -> x isa Axis, f.figure.content)\nfor ax1 in axs\n    keepat!(ax1.xaxislinks, samecol.(Ref(ax1), ax1.xaxislinks))\nend\n\nwarning: Warning\nNoted that those axes is not limited in the collection of axs.\nInput axs combined from different grid layout might lead to malfunction, since it checks only the span of gridcontent to see the row or column range are identical, but do not check whether the origin of gridcontent is the same.\n\nSee also: samecol, samerow, colrange, rowrange\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.keeponlysamerowlinked!-Tuple{Any}","page":"Home","title":"OkMakieToolkits.keeponlysamerowlinked!","text":"keeponlysamerowlinked!(axs::Vector{Axis}) is similar to keeponlysamecollinked!, but for axis on the same row range stay linked on y axis.\n\nSee the docstring of keeponlysamecollinked!.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.mkgen_hollow-Tuple{Number}","page":"Home","title":"OkMakieToolkits.mkgen_hollow","text":"mkgen_hollow(markersize::Number; linewidth=1, outer_radius=80) generates hollow circle as a Polygon, which can be used for the marker kwarg of scatter!.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.mkgen_solid-Tuple{}","page":"Home","title":"OkMakieToolkits.mkgen_solid","text":"mkgen_solid(;outer_radius=80) generates solid circle as a Polygon, which can be used for the marker kwarg of scatter!.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.rowrange-Tuple{Any}","page":"Home","title":"OkMakieToolkits.rowrange","text":"rowrange(block) returns the row range of the block (Axis).\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.secondyaxis-Tuple{Any}","page":"Home","title":"OkMakieToolkits.secondyaxis","text":"secondyaxis(f_grid; color = :black, ylabel = \"y\") returns an Axis object of y axis to the right-hand side, with default settings for yyplot.\n\nExample\n\nf = Figure()\nax_right = secondyaxis(f[1,1]; color=:red)\n\n\n\nthat you can do lines!(ax_right, ...)\n\nFurther reading\n\nIs it possible to add a secondary y axis?\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.shrinkylim!-Tuple{Any, Vector{<:Number}}","page":"Home","title":"OkMakieToolkits.shrinkylim!","text":"shrinkylim!(ax, ydatas::Vector{<:Number}; extent = 0.15) fit y-limits to the input ydatas to with a certain extent.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.timeseriesplot!-Tuple","page":"Home","title":"OkMakieToolkits.timeseriesplot!","text":"This is an experimental plot function of timeseriesplot. It takes x::AbstractVector{<:Real} and values::AbstractVector{<:PredictData}, where\n\nx and values automatically become Observable inside the plot! function due to Makie's magic.\nadditional Observables should be defined if you want the plot to be updated on the change of data.\nIn this recipe, we do not define color of lines/scatters as Observable that color won't update.\n\nExample\n\nf = Figure();\ntimeseriesplot(f[1,1], x, values; testcolor=:brown2, realcolor=:blue, markersize=3)\n# or\nax = Axis(f[1,2])\ntimeseriesplot!(ax, x, values)\n# or\n(f, ax, p) = timeseriesplot(TX.x[(firsttrain+1):end], [OT...])\n\nSee also\n\nThis function is created referencing Example: Stock Chart\nYou may see The recipe of raincloud for a more advanced utility of recipe. Noted that they use @recipe(RainClouds, category_labels, data_array) do scene, not just @recipe(RainClouds) do scene\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.timeseriesplot-Tuple","page":"Home","title":"OkMakieToolkits.timeseriesplot","text":"This is an experimental plot function of timeseriesplot. It takes x::AbstractVector{<:Real} and values::AbstractVector{<:PredictData}, where\n\nx and values automatically become Observable inside the plot! function due to Makie's magic.\nadditional Observables should be defined if you want the plot to be updated on the change of data.\nIn this recipe, we do not define color of lines/scatters as Observable that color won't update.\n\nExample\n\nf = Figure();\ntimeseriesplot(f[1,1], x, values; testcolor=:brown2, realcolor=:blue, markersize=3)\n# or\nax = Axis(f[1,2])\ntimeseriesplot!(ax, x, values)\n# or\n(f, ax, p) = timeseriesplot(TX.x[(firsttrain+1):end], [OT...])\n\nSee also\n\nThis function is created referencing Example: Stock Chart\nYou may see The recipe of raincloud for a more advanced utility of recipe. Noted that they use @recipe(RainClouds, category_labels, data_array) do scene, not just @recipe(RainClouds) do scene\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.to_gridposition-Tuple{Any}","page":"Home","title":"OkMakieToolkits.to_gridposition","text":"Example\n\nusing CairoMakie, AlgebraOfGraphics, DataFrames\n\nf = Figure()\ndf = DataFrame(a=repeat(1:3, outer=2),\n    b=randn(6),\n    d=repeat(1:3, inner=2),\n    e=[\"(a)\", \"(a)\", \"(a)\", \"(b)\", \"(b)\", \"(b)\"])\n\nplts = data(df) * visual(Lines) * mapping(:a, :b) * mapping(layout=:e)\n\ndraw!(f[1, 1], plts)\n\naxs = filter(x -> x isa Axis, f.content) # a vector of two axes, panel (a) and (b)\n\nposs = to_gridposition.(axs)\n\ndatapoint_for_right = (collect(1:5), randn(5))\n\n# plot `datapoint_for_right` with an individual y axis on the right for each `axs` on `poss`\nfor figpos in poss\n    right_ax = Axis(figpos[:, :]; yaxisposition=:right, ygridvisible=false) # create a\n    scatter!(right_ax, datapoint_for_right...)\nend\n\n# output\n\n\n\nThis function is contributed by Julius Krumbiegel on the makie channel of Slack, 2023-08-23.\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.twinaxis-Tuple{GridLayoutBase.GridPosition}","page":"Home","title":"OkMakieToolkits.twinaxis","text":"twinaxis(figpos::GridPosition; left_color=:black, right_color=:dodgerblue, left_axis=(;), right_axis=(;)) returns (left_ax, right_ax) for the left- and right- axis of the same plot on figpos.\n\nBy default, yticklabelcolor ytickcolor and left (right) spinecolor for left (right) axis is set to left_color (right_color). However, these default settings can be overwritten by assigning the name tuple for axis' attribute to keyword argument left_axis (right_axis).\n\nExample\n\nusing Makie, OkMakieToolkits\nf = Figure()\nleft_ax, right_ax = twinaxis(f[1,1];\n    left_color = :black, # left side looks all in black\n    left_axis = (; yticklabelcolor = :blue) # despite left yticklabel; its blue.\n)\n\nleft_ax.yticklabelcolor[]\n\n# output\nRGBA{Float32}(0.0f0,0.0f0,1.0f0,1.0f0)\n\nRef: https://beautiful.makie.org/dev/examples/generated/2d/lines/linetwinaxis/\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.twinaxis-Tuple{Makie.Axis}","page":"Home","title":"OkMakieToolkits.twinaxis","text":"twinaxis(ax::Axis; color=:dodgerblue, other=(;)): Given an ax, the ax2::Axis of the other side is pinned to the grid position of ax; it returns ax2.\n\nExample\n\nusing CairoMakie, AlgebraOfGraphics, DataFrames\n\nf = Figure()\ndf = DataFrame(a=repeat(1:3, outer=2),\n    b=randn(6),\n    d=repeat(1:3, inner=2),\n    e=[\"(a)\", \"(a)\", \"(a)\", \"(b)\", \"(b)\", \"(b)\"])\n\nplts = data(df) * visual(Lines) * mapping(:a, :b) * mapping(layout=:e)\n\ndraw!(f[1, 1], plts)\n\naxs = filter(x -> x isa Axis, f.content) # a vector of two axes, panel (a) and (b)\n\ntwaxs = twinaxis.(axs)\n\nx = collect(1:5)\ny = randn(5)\n\nfor ax in twaxs\n    scatter!(ax, x, y)\nend\n\nfor (ax1, ax2) in zip(axs, twaxs)\n    @assert ax1.yaxisposition[] == :left\n    @assert ax2.yaxisposition[] == :right\nend\n\n# output\n\n\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.twohstackedboxes!-Tuple","page":"Home","title":"OkMakieToolkits.twohstackedboxes!","text":"Define left::Period, middle::TimeType, and right::Period of each TwoHBoxes for two-segment bar, and plot these bars aligned with x axis with each corresponds to y ticks of 1:length(TTMs) using twohstackedboxes(TTMs) where TTMs::Vector{<:TwoHBoxes}.\n\nExample\n\nusing Dates, Makie\nTTMs = [TwoHBoxes(Day(60), dt, Day(10), \"Test $i\") for (i, dt) in enumerate(Date(2020,1,1):Month(1):Date(2021,1,1))]\nf = Figure()\nax = Axis(f[:,:])\nout = twohstackedboxes!(ax, TTMs)\nout\n\nNoted that twohstackedboxes! not only mutate ax::Axis but also mutate TTM in TTMs, where left, middle, right is shifted by offset if unit is DateTime, since the ordinal number of Millisecond for DateTime is too large that will make Makie's plot wrongly displayed without raising an error.\n\nSee also\n\nThis function is created referencing Julia Data Science: A Makie recipe for a DataFrame\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.twohstackedboxes-Tuple","page":"Home","title":"OkMakieToolkits.twohstackedboxes","text":"Define left::Period, middle::TimeType, and right::Period of each TwoHBoxes for two-segment bar, and plot these bars aligned with x axis with each corresponds to y ticks of 1:length(TTMs) using twohstackedboxes(TTMs) where TTMs::Vector{<:TwoHBoxes}.\n\nExample\n\nusing Dates, Makie\nTTMs = [TwoHBoxes(Day(60), dt, Day(10), \"Test $i\") for (i, dt) in enumerate(Date(2020,1,1):Month(1):Date(2021,1,1))]\nf = Figure()\nax = Axis(f[:,:])\nout = twohstackedboxes!(ax, TTMs)\nout\n\nNoted that twohstackedboxes! not only mutate ax::Axis but also mutate TTM in TTMs, where left, middle, right is shifted by offset if unit is DateTime, since the ordinal number of Millisecond for DateTime is too large that will make Makie's plot wrongly displayed without raising an error.\n\nSee also\n\nThis function is created referencing Julia Data Science: A Makie recipe for a DataFrame\n\n\n\n\n\n","category":"method"}]
}
