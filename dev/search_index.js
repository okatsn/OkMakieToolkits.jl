var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = OkMakieToolkits","category":"page"},{"location":"#OkMakieToolkits","page":"Home","title":"OkMakieToolkits","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for OkMakieToolkits.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [OkMakieToolkits]","category":"page"},{"location":"#OkMakieToolkits.blankaxis!-Union{Tuple{T}, Tuple{Any, T, T, T, T}} where T<:AbstractFloat","page":"Home","title":"OkMakieToolkits.blankaxis!","text":"blankaxis!(fpos, xmin::T, ymin::T, xmax::T, ymax::T) where {T<:AbstractFloat} creates an empty Makie Axis object at grid position fpos.\n\nExample\n\nf = Figure(;resolution=(1400,1000))\ngleft = f[1:3, 1] = GridLayout()\ngright = f[1:3, 2:3] = GridLayout()\nfpos = gright[0, :]\nblankaxis!(fpos, xmin, ymin, xmax, ymax)\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.dataoverview!-Tuple{DataFrames.DataFrame, DataType}","page":"Home","title":"OkMakieToolkits.dataoverview!","text":"dataoverview!(df::DataFrame, xtype::DataType; gridsize = gridsize, set_left_edge=leftfn, set_right_edge=rightfn) plot the overview of data in  DataFrame df. xtype specify the only column type (e.g., DateTime) for x-axis.\n\nExample\n\nusing Dates, DataFrames, OkMakieToolkits, Makie\na = randn(100)\na[1:20] .= NaN\nb = Vector{Union{Missing, Float64}}(undef, 100)\nb[1:70] .= randn(70)\nb[71:90] .= NaN\nb[91:100] .= missing\ntable_nan = DataFrame(:a => [1,2,NaN], :b => [missing,missing,5], :dt => collect(DateTime(\"2022-01-01T00:00:00\"):Day(1):DateTime(\"2022-01-03T00:00:00\")))\nf, ax, dfxx = dataoverview!(table_nan, DateTime; resolution = (800,500))\nMakie.save(\"Fig_dataoverview.eps\", f)\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.datetimeticks!-Tuple{Any, Vector{Dates.DateTime}, Vector, Dates.DatePeriod}","page":"Home","title":"OkMakieToolkits.datetimeticks!","text":"Similar to datetimeticks!(ax2, t::Vector{DateTime}, x_a::Vector), datetimeticks!(ax2, t::Vector{DateTime}, x_a::Vector, tinc::DatePeriod; datestrformat = \"yyyy/mm/dd\", modify_fn = identity) return xticks, xticklabels with xticks forced to increase with step tinc, and be modify by function modify_fn.\n\nExample\n\ndatetimeticks!(\n    ax2,\n    [DateTime(2012,2,5,3,15,0), DateTime(2012,3,5,3,15,0)],\n    [0, 1], # `x` for `Makie.plot(x, ...)`\n    Day(3); # tick every 3 days\n    datestrformat = \"yyyy/mm/dd\",\n    modify_fn = x -> floor.(x, Day)\n)\n\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.datetimeticks!-Tuple{Any, Vector{Dates.DateTime}, Vector}","page":"Home","title":"OkMakieToolkits.datetimeticks!","text":"datetimeticks!(ax2, t::Vector{DateTime}, x::Vector; datestrformat = \"yyyy/mm/dd\") set x ticks to datestr format. t is the DateTime array that is not supported by Makie, x is a arbitrarily defined series of numbers that corresponds to t for Makie.plot. x and t must be the same length and should be pairwisely mapped.\n\nExample:\n\nt = df.datetime\nx = Dates.datetime2epochms.(t)\nx1 = x .- x[1] # to avoid glitchs in plotting with CairoMakie (due to the too-large values)\ny = df.soil_water\nCairoMakie.scatter!(ax, x, y, markersize =3)\ndatetimeticks!(ax2, t,x)\n\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.expandxylim!-NTuple{5, Any}","page":"Home","title":"OkMakieToolkits.expandxylim!","text":"expandxylim!(ax, upper_expand_x, lower_expand_x, lower_expand_y, upper_expand_y) TODO: merge with expandylim! in makietools.jl\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.expandylim!-Tuple{Any, Any}","page":"Home","title":"OkMakieToolkits.expandylim!","text":"expandylim!(ax, upper_expand) expand the upper limit of y axis to a ratio of upper_expand of the original y range (ymax - ymin).\n\nExample\n\nexpandylim!(ax, 0.25)\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.getxylimits-Tuple{Any}","page":"Home","title":"OkMakieToolkits.getxylimits","text":"Example\n\nxmin, ymin, xmax, ymax = getxylimits(ax)\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.secondyaxis-Tuple{Any}","page":"Home","title":"OkMakieToolkits.secondyaxis","text":"secondyaxis(f_grid; color = :black, ylabel = \"y\") returns an Axis object of y axis to the right-hand side, with default settings for yyplot.\n\nExample\n\nf = Figure()\nax_right = secondyaxis(f[1,1]; color=:red)\n\n\n\nthat you can do lines!(ax_right, ...)\n\nFurther reading\n\nIs it possible to add a secondary y axis?\n\n\n\n\n\n","category":"method"},{"location":"#OkMakieToolkits.shrinkylim!-Tuple{Any, Vector{<:Number}}","page":"Home","title":"OkMakieToolkits.shrinkylim!","text":"shrinkylim!(ax, ydatas::Vector{<:Number}; extent = 0.15) fit y-limits to the input ydatas to with a certain extent.\n\n\n\n\n\n","category":"method"}]
}
