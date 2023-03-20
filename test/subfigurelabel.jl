@testset "subfigurelabel.jl" begin
    @info "Testing subfigurelabel.jl"
    alllabels = ["($ch)" for ch in collect('a':'z')]
    @test isequal([str for str in SubfigureLabel(7)], alllabels[1:7])
    @test isequal([str for str in SubfigureLabel(26)], alllabels[1:26])
    @test_throws "" [str for str in SubfigureLabel(27)]
end
