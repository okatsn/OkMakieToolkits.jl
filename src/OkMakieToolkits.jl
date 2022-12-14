module OkMakieToolkits

# Write your package code here.

using Dates
using DataFrames
import ShiftedArrays: lag as lag
import DataFrames: transform as dftrans, transform! as dftrans!
using DataFrameTools
using Statistics
using CairoMakie
include("dataoverview.jl")
export dataoverview!



include("axisrecipes.jl")
export secondyaxis, blankaxis!, setxticklabelsoff!

include("manipulatelimits.jl")
export getxylimits, expandylim!, shrinkylim!, expandxylim!


using PlotUtils: optimize_ticks
using Dates
include("datetimeticks.jl")
export datetimeticks!, datetime2epochs, TimeAsX

using GeometryBasics
include("custommarkers.jl")
export PairedCircleGenerator

include("linkaxes.jl")
export linkaxes!, linkxaxes!, linkyaxes!
end
