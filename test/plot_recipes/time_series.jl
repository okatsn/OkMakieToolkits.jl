@testset "API and default behavior of PredictData" begin
    pd = PredictData(1.1, 2.3)
    @test pd.pred == 1.1
    @test pd.real == 2.3
    @test pd.fold == 0
end
