@testset "traintestwindow.jl" begin
    using Dates, Makie
    TTM = TwoHBoxes(Day(60), Date(2020, 1, 1), Day(10), "test 1")
    TTM = TwoHBoxes(Day(60), DateTime(2020, 1, 1), Day(10), "test 2")
    TTMs = [TwoHBoxes(Day(60), dt, Day(10), "test $i") for (i, dt) in enumerate(Date(2020, 1, 1):Month(1):Date(2021, 1, 1))]
    f = Figure()
    ax = Axis(f[:, :])
    out = twohstackedboxes!(ax, TTMs)
    @test TTMs[1].left != 0
    f
    @testset isnothing(only(unique([TTM.offset for TTM in TTMs])))


    TTMsDT = [TwoHBoxes(Day(60), dt, Day(10), "test $i") for (i, dt) in enumerate(DateTime(2020, 1, 1):Month(1):DateTime(2021, 1, 1))]
    offset0 = TTMsDT[1].left

    f = Figure()
    ax = Axis(f[:, :])
    out = twohstackedboxes!(ax, TTMsDT)
    @test TTMsDT[1].left == 0 || "It should be shifted to zero if the unit is `Millisecond`."
    datetimeticks!(ax, TTMsDT) # TODO: test datetimeticks! for TTM or test _int2time, _time2int
    ax.xticklabelrotation = 0.2π
    f
    @test only(unique([TTM.offset for TTM in TTMsDT])) == offset0 || "It should be shifted with an offset $offset0"


end


@testset "test _offset!" begin
    # OkMakieToolkits._offset!(TTMsDT)

end
