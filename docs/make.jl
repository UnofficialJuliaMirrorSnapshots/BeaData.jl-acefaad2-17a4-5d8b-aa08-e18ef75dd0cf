using Documenter
using BeaData

makedocs(
    modules = [BeaData],
    sitename = "BeaData.jl",
    pages = Any[
        "Home" => "index.md",
    ],
    doctest = false
)

#deploydocs(
#    repo = "github.com/stephenbnicar/BeaData.jl.git"
#)
