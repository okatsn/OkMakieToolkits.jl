module OkMakieToolkits

## Common functions
using Dates
include("approximatelyidentical.jl")

## Ploting tools
using CairoMakie

include("axisrecipes.jl")
export secondyaxis, blankaxis!, setxticklabelsoff!

include("manipulatelimits.jl")
export getxylimits, expandylim!, shrinkylim!, expandxylim!


using PlotUtils: optimize_ticks
using Dates
include("datetimeticks.jl")
export datetimeticks!, datetime2epochs, TimeAsX, RangedTimeAsX

using GeometryBasics
include("custommarkers.jl")
export PairedCircleGenerator

include("linkaxes.jl")
export linkaxes!, linkxaxes!, linkyaxes!








## Recipes
using CairoMakie
include("plot_recipes/time_series.jl")
export PredictData, get_plot_elements, timeseriesplot


end
