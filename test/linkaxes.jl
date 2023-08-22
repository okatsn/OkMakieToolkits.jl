@testset "linkaxes.jl" begin
    using Makie, OkMakieToolkits
    x = 1:10
    y1 = randn(10)
    y2 = 1 .+ 2 * randn(10)
    f = Figure()
    ax1 = Axis(f[1, 1])
    ax2 = Axis(f[1, 2])
    lines!(ax1, x, y1)
    scatter!(ax2, x, y2)

    Makie.update_state_before_display!(f)

    @test !isequal(getlimits(ax1, 2), getlimits(ax2, 2))

    linkaxes!(f)

    Makie.update_state_before_display!(f)

    @test isequal(getlimits(ax1, 2), getlimits(ax2, 2))


end
