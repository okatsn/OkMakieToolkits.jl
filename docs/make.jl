using OkMakieToolkits
using Documenter

DocMeta.setdocmeta!(OkMakieToolkits, :DocTestSetup, :(using OkMakieToolkits); recursive=true)

makedocs(;
    modules=[OkMakieToolkits],
    authors="okatsn <okatsn@gmail.com> and contributors",
    repo="https://github.com/okatsn/OkMakieToolkits.jl/blob/{commit}{path}#{line}",
    sitename="OkMakieToolkits.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://okatsn.github.io/OkMakieToolkits.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/okatsn/OkMakieToolkits.jl",
    devbranch="main",
)
