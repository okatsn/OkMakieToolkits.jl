@testset "datetimeticks.jl" begin
    t = DateTime(2012,2,2):Day(1):DateTime(2015,2,2)
    t0v = collect(t)
    x0v = collect(eachindex(t))

    argsets = ((t, ), (x0v, t), (x0v, t0v))
    for args in argsets
        TX = TimeAsX(args...)

        @test isequal(t0v, TX.t)
        @test isequal(x0v, TX.x)
    end
end
