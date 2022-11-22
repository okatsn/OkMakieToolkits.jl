var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = OkMakieToolkits","category":"page"},{"location":"#OkMakieToolkits","page":"Home","title":"OkMakieToolkits","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for OkMakieToolkits.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [OkMakieToolkits]","category":"page"},{"location":"#OkMakieToolkits.dataoverview!-Tuple{DataFrames.DataFrame, DataType}","page":"Home","title":"OkMakieToolkits.dataoverview!","text":"dataoverview!(df::DataFrame, xtype::DataType; gridsize = gridsize, set_left_edge=leftfn, set_right_edge=rightfn) plot the overview of data in  DataFrame df. xtype specify the only column type (e.g., DateTime) for x-axis.\n\nExample\n\nusing Dates, DataFrames, OkMakieToolkits, Makie\na = randn(100)\na[1:20] .= NaN\nb = Vector{Union{Missing, Float64}}(undef, 100)\nb[1:70] .= randn(70)\nb[71:90] .= NaN\nb[91:100] .= missing\ntable_nan = DataFrame(:a => [1,2,NaN], :b => [missing,missing,5], :dt => collect(DateTime(\"2022-01-01T00:00:00\"):Day(1):DateTime(\"2022-01-03T00:00:00\")))\nf, ax, dfxx = dataoverview!(table_nan, DateTime; resolution = (800,500))\nMakie.save(\"Fig_dataoverview.eps\", f)\n\n\n\n\n\n","category":"method"}]
}