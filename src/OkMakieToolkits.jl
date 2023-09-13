module OkMakieToolkits

using Makie

## Common functions
using Dates
include("approximatelyidentical.jl")

## Ploting tools

### Grid position and linking axis

include("to_gridposition.jl")
export to_gridposition

include("colrowlink.jl")
export colrange, rowrange
export keeponlysamecollinked!, keeponlysamerowlinked!

include("twinaxes.jl")
export twinaxis

### Axis attributes

include("axisrecipes.jl")
export secondyaxis, blankaxis!, setxticklabelsoff!

include("manipulatelimits.jl")
export getxylimits, expandylim!, shrinkylim!, expandxylim!, getlimits


using PlotUtils: optimize_ticks
using Dates
include("datetimeticks.jl")
export datetimeticks!, datetime2epochs, TimeAsX, RangedTimeAsX

using GeometryBasics
include("custommarkers.jl")
export PairedCircleGenerator

include("linkaxes.jl")
export linkaxes!, linkxaxes!, linkyaxes!

### Others

using ShiftedArrays: lag
using Chain, DataFrames
include("lineseg.jl")
export ContinuousLineSegments


include("subfigurelabel.jl")
export SubfigureLabel


include("colors/categorical_colors.jl")

using Colors: LCHab, distinguishable_colors, deuteranopic

include("colors/gadfly_colors.jl")


## Recipes
using Makie
include("plot_recipes/time_series.jl")
export PredictData, get_plot_elements, timeseriesplot


include("plot_recipes/traintestwindow.jl")
export TwoHBoxes
export setyticks!

end
