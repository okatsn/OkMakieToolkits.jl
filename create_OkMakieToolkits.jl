using PkgTemplates

# Ref: https://juliaci.github.io/PkgTemplates.jl/stable/user/
t = Template(
    user = "okatsn",
    dir = joinpath(pwd(),"temp","dev"),
    author = "Tsung-Hsi, Wu",
    julia = v"1.6",
    plugins = [
        Tests(),
        Readme(),
        License(; name="MIT"),
        Git(;
            ignore=String[".vscode/","old/","temp/"],
            name="okatsn",             # only required if user.name  is not set for Git
            email="okatsn@gmail.com",  # only required if user.email is not set for Git
            ssh=false,
            jl=true,
            manifest=false,
            gpgsign=false,
        ),
        TagBot(;
            destination="TagBot.yml",
            token=Secret("GITHUB_TOKEN"),
            registry="https://github.com/okatsn/OkRegistry.git"
        ),
        Secret("GENERAL_JULIA_PKG"),
        Codecov(),
        GitHubActions(;
            destination="DocCI.yml",
            linux=true,
            osx=false,
            windows=false,
            x64=true,
            x86=false,
            coverage=true,
        ),
        Documenter{GitHubActions}(),
        ]
)
t("OkMakieToolkits")
