@testset "traintestwindow.jl" begin
    using Dates, CairoMakie
    TTM = TrainTestMarker(Day(60), Date(2020,1,1), Day(10), "test 1")
    TTM = TrainTestMarker(Day(60), DateTime(2020,1,1), Day(10), "test 2")
    TTMs = [TrainTestMarker(Day(60), dt, Day(10), "test $i") for (i, dt) in enumerate(Date(2020,1,1):Month(1):Date(2021,1,1))]
    f = Figure()
    ax = Axis(f[:,:])
    out = traintestphase!(ax, TTMs)
    f
    @testset isnothing(only(unique([TTM.offset for TTM in TTMs])))


    TTMsDT = [TrainTestMarker(Day(60), dt, Day(10), "test $i") for (i, dt) in enumerate(DateTime(2020,1,1):Month(1):DateTime(2021,1,1))]
    offset0 = TTMsDT[1].left

    f = Figure()
    ax = Axis(f[:,:])
    out = traintestphase!(ax, TTMsDT)
    f
    @test only(unique([TTM.offset for TTM in TTMsDT])) == offset0
end


@testset "test _offset!" begin
    # OkMakieToolkits._offset!(TTMsDT)

end
