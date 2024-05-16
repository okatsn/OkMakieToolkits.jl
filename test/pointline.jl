@testset "pointline.jl" begin
    twopoints = [
        (cos(π), sin(π)) => (cos(0.5π), sin(0.5π)) => 0.5π,
        (3cos(π), 3sin(π)) => (cos(0.5π), sin(0.5π)) => 0.5π,
        (cos(0.1π), sin(0.1π)) => (cos(-0.5π), sin(-0.5π)) => 0.6π,
        (cos(-0.5π), sin(-0.5π)) => (2.3cos(0.1π), 2.3sin(0.1π)) => -0.6π,
    ]
    for (a, (b, r)) in twopoints
        @test isapprox(OkMakieToolkits.angled2(a, b), rad2deg(r))
    end
end
