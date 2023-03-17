@testset "ContinuousLineSegments" begin
    using DataFrames
    df = DataFrame(
        :t => collect(range(0,1,length=100)),
        :X => randn(100),
        :Y => 3*randn(100) .+ 10.0,
        :W => vcat(fill("hello", 20), fill("world",80)),
        :Z => vcat(fill(1, 20), fill(2,80)),
    )
    allowmissing!(df)

    makemissing!(v, id) = setindex!(v, missing, id)
    makemissing!(df.W, 7)
    makemissing!(df.W, 99)

    for k in [:X, :Y]
        df[rand(1:nrow(df), 5), k] .= fill(missing, 5)
    end # randomly assign missing values for each column


    df0 = deepcopy(df)
    CLS = ContinuousLineSegments(df, :t, (:X, :Y); otherkeys = [:W, :Z])
    df1 = CLS.table
    orderkey = CLS.orderkey
    valuekeys = CLS.valuekeys
    otherkeys = CLS.otherkeys

    @test isequal(df1[1:2:end, orderkey], df0[1:end-1, orderkey]) # test if time tagged to the tail of each segment

    for vk in vcat(valuekeys..., otherkeys...)
        @test isequal(df1[2:2:end, vk], df0[2:end, vk]) # test if the tail of each segment is identical with the original ones in table
    end

    allkeys = vcat(orderkey, valuekeys..., otherkeys...)
    alltypes = [eltype(df0[!, k]) for k in allkeys]

    for (k, eltp) in zip(allkeys, alltypes)
        @test isequal(eltp, eltype(df1[!, k]))
    end


end
