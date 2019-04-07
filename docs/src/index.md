# BeaData.jl

## Obtaining a UserID

A valid UserID is required to access the BEA Data API.  An ID can be obtained by registering
at the BEA website.

## Storing your UserID
```@docs
Bea
```

## Get a list of available datasets
```@docs
get_bea_datasets(b::Bea)
```

## Get a list of parameters for a dataset
```@docs
get_bea_parameterlist(b::Bea, dataset::String)
```
## Get a list of values for a parameter
