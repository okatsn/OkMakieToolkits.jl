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

end
