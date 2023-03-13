@testset "ContinuousLineSegments" begin
    using DataFrames
    df = DataFrame(
        :t => collect(range(0,1,length=100)),
        :X => randn(100),
        :Y => 3*randn(100) .+ 10.0
    )
    allowmissing!(df)

    for k in [:X, :Y]
        df[rand(1:nrow(df), 5), k] .= fill(missing, 5)
    end # randomly assign missing values for each column


    df0 = deepcopy(df)
    CLS = ContinuousLineSegments(df, :t, [:X, :Y])
    df1 = CLS.table
    orderkey = CLS.orderkey
    valuekeys = CLS.valuekeys

    @test isequal(df1.order[1:2:end], df0[1:end-1, orderkey]) # test if time tagged to the tail of each segment

    for vk in valuekeys
        @test isequal(df1[2:2:end, vk], df0[2:end, vk]) # test if the tail of each segment is identical with the original ones in table
    end



end
