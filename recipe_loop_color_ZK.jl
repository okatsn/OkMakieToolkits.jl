using CairoMakie

@recipe Plot_1d_Layer_Model (thicknesses, values) begin
    "Elevation of the surface"
    z0 = 0
    Makie.documented_attributes(Stairs)...
end

function Makie.plot!(plot::Plot_1d_Layer_Model)
    thicknesses = plot[1][]
    values = plot[2][]
    z0 = plot[:z0][]

    x = vcat(values, values[end])
    y = vcat(z0, z0 .- cumsum(thicknesses), -1e10)

    stairs!(plot, plot.attributes, x, y)

    return plot
end

fig = Figure(size=(900, 600))
ax = Axis(fig[1, 1], xlabel="Resistivity (Ω·m)", ylabel="Elevation (m)")
ylims!(ax, (-300, 50))

true_model = [100, 40, 20]
true_layers = [100.0, 100.0]
plot_1d_layer_model!(ax, true_layers, true_model; label="Model 1")

true_model = [80, 90, 50]
true_layers = [50.0, 100.0]
plot_1d_layer_model!(ax, true_layers, true_model; label="Model 2")

true_model = [10, 70, 0]
true_layers = [30.0, 80.0]
plot_1d_layer_model!(ax, true_layers, true_model; z0=-10, color=:red, label="Model 3")
axislegend(position=:rb)

display(fig)
