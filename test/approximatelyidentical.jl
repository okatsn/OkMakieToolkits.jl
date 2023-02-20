@testset "approximatelyidentical.jl" begin
    @test reduce((a,b) -> OkMakieToolkits.approxid(a, b; atol = 2), [11.5, 10, 13, 12]) == 11.5
end
