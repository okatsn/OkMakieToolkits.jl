using Dates

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

@testset "TimeAsX, RangedTimeAsX" begin
    @test try
        TimeAsX([1,2,4,7,8],
                [DateTime(2022,1,1),
                    DateTime(2022,1,2),
                    DateTime(2022,1,4),
                    DateTime(2022,1,7),
                    DateTime(2022,1,8)
                ]);
        true
    catch e
        false
    end

    @test try
        TimeAsX([1,2,4,7,8],
                [DateTime(2022,1,1),
                    DateTime(2022,1,2),
                    DateTime(2022,1,3),
                    DateTime(2022,1,4),
                    DateTime(2022,1,5)
                ]);
        false
    catch e
        true
    end

    TX = TimeAsX([1,2,4,7,8], # non-uniform TX
            [DateTime(2022,1,1),
                DateTime(2022,1,2),
                DateTime(2022,1,4),
                DateTime(2022,1,7),
                DateTime(2022,1,8)
            ]
        );
    UTX = TimeAsX([1,2,3,4,5], # uniformed TX
                [DateTime(2022,1,1),
                    DateTime(2022,1,2),
                    DateTime(2022,1,3),
                    DateTime(2022,1,4),
                    DateTime(2022,1,5)
                ]);
    @test try RangedTimeAsX(UTX); true catch e; false end
    @test try RangedTimeAsX(TX); false catch e; true end
end
