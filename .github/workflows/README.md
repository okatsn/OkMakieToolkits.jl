# Short notes for CI
## Documenter
- You have to do this everytime before `julia-actions/julia-buildpkg@v1` because `OkMakieToolkits` uses packages in this registry:
    ```
      - run: |
          julia --project=@. -e '
            using Pkg;
            Pkg.Registry.add(RegistrySpec(url = "https://github.com/okatsn/OkRegistry.git"))
            '
    ```
- You have to go to [settings/pages](https://github.com/okatsn/OkMakieToolkits.jl/settings/pages) and set "Deploy from a branch" with `gh-pages`
- Well done!
- See `DocCI.yml`
