using CairoMakie

# A simple approach: manually implement automatic color cycling
# by keeping track of how many plots have been made

const _plot_count = Ref(0)

function plot_1d_layer_model!(ax, thicknesses, values; color=nothing, kwargs...)
    # Get current color palette
    palette = ax.scene.theme.palette.color[]

    # If no color specified, use next color from palette
    if color === nothing
        _plot_count[] += 1
        color = palette[mod1(_plot_count[], length(palette))]
    end

    # Compute the data
    x = vcat(values, values[end])
    y = vcat(0, 0 .- cumsum(thicknesses), -1e10)

    # Plot using stairs! with the determined color
    return stairs!(ax, x, y; color=color, kwargs...)
end

# Minimum workable example
fig = Figure(size=(900, 600))
ax = Axis(fig[1, 1], xlabel="Resistivity (Ω·m)", ylabel="Elevation (m)")
ylims!(ax, (-300, 50))

# First model - will use first color in cycle (usually blue)
true_model_1 = [100, 40, 20]
true_layers_1 = [100.0, 100.0]
plot_1d_layer_model!(ax, true_layers_1, true_model_1; label="Model 1")

# Second model - will use second color in cycle (usually red)
true_model_2 = [80, 90, 50]
true_layers_2 = [50.0, 100.0]
plot_1d_layer_model!(ax, true_layers_2, true_model_2; label="Model 2")

# Third model - will use third color in cycle (usually green)
true_model_3 = [120, 60, 30]
true_layers_3 = [75.0, 125.0]
plot_1d_layer_model!(ax, true_layers_3, true_model_3; label="Model 3")

# Fourth model - will use fourth color in cycle (usually orange)
true_model_4 = [95, 75, 40]
true_layers_4 = [60.0, 110.0]
plot_1d_layer_model!(ax, true_layers_4, true_model_4; label="Model 4")

# Add legend to show the automatic color cycling
axislegend(ax)

# Save the figure to see the result
save("layer_model_cycling_demo.png", fig)

# Also display
fig
