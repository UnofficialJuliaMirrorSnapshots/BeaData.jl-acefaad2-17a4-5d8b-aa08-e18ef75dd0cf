# BeaData

*A Julia interface for retrieving data from the U.S. Bureau of Economic Analysis (BEA)
Data API.*

| **Documentation** | **Repo Status** | **Build Status** | **Coverage** |
|:-------------:|:-------------:|:----------------:|:------------:|
|[![][docs-stable-img]][docs-stable-url]|[![Project Status: Active][repo-img]][repo-url] | [![][travis-img]][travis-url] [![AppVeyor][appveyor-img]][appveyor-url] | [![codecov.io][codecov-img]][codecov-url] |


## Installation

At the Julia REPL:

```julia
    (v1.1) pkg> add BeaData
```
A UserID is required to use the BEA's API. A UserID can be obtained by registering [here](http://www.bea.gov/API/signup/index.cfm).

## Disclaimer
BeaData.jl is not affiliated with, officially maintained, or otherwise supported by the Bureau of Economic Analysis.

[docs-latest-img]: https://img.shields.io/badge/docs-latest-blue.svg
[docs-latest-url]: https://stephenbnicar.github.io/BeaData.jl/latest

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://stephenbnicar.github.io/BeaData.jl/stable

[travis-img]: https://travis-ci.org/stephenbnicar/BeaData.jl.svg?branch=master
[travis-url]: https://travis-ci.org/stephenbnicar/BeaData.jl

[appveyor-img]: https://ci.appveyor.com/api/projects/status/vs710r7oqax2b25m/branch/master?svg=true
[appveyor-url]: https://ci.appveyor.com/project/stephenbnicar/beadata-jl/branch/master

[codecov-img]: http://codecov.io/github/stephenbnicar/BeaData.jl/coverage.svg?branch=master
[codecov-url]: http://codecov.io/github/stephenbnicar/BeaData.jl?branch=master

[repo-img]: http://www.repostatus.org/badges/latest/active.svg
[repo-url]: http://www.repostatus.org/#active
