module BeaData

import HTTP
import JSON
using  Dates
using  DataFrames

import Base.show

export
    Bea,
    get_bea_datasets,
    get_bea_parameterlist

const API_URL = "https://apps.bea.gov/api/data"

"""
    Bea([::String])

A `struct` holding the URL and UserID needed to retreive data from the BEA Data API.

Before using any of the data retrieval functions, you must create an instance of `Bea()`
to hold your UserID, which may be done in either of the following ways.

Provide the UserID directly as a `String` argument to the constructor:
```julia
julia> b = Bea("your-UserID")
```
Include the UserID in a file named `.beadatarc` in your home directory, and call the constructor without an argument:
```julia
julia> b = Bea()
```
"""
mutable struct Bea
    url::AbstractString
    UserID::AbstractString
end

Bea(UserID) = Bea(API_URL, UserID)

function Bea()
    UserID = ""
    if "BEA_KEY" in keys(ENV)
        UserID = ENV["BEA_KEY"]
    elseif isfile(joinpath(homedir(), ".beadatarc"))
        open(joinpath(homedir(),".beadatarc"), "r") do f
            UserID = read(f, String)
        end
        UserID = rstrip(UserID)
    else
        error("No UserID found, connection not initialized")
    end

    println("UserID loaded.")

    return Bea(UserID)
end

function Base.show(io::IO, b::Bea)
    println(io, "BEA UserID container")
    println(io, "URL:    $(b.url)")
    println(io, "UserID: $(b.UserID)")
end


# """
# A NIPA table with data and metadata returned from a [`get_nipa_table`](@ref) call.
#
# Fields
# ---
#
# * tablenum - NIPA table number
# * tablename - API TableName
# * tabledesc - The table title (e.g., 'Real Gross Domestic Product, Chained Dollars' for Table 1.1.6)
# * linedesc - `OrderedDict` of descriptions for each line of the table
# * tablenotes - Table notes, if any
# * frequency
# * startyear
# * endyear
# * df - `DataFrame` containing the data values from the table; column names are the line numbers from the table, the first column contains the date for each observation in Julia `Date` format
#
# """
# mutable struct BeaTable
#     tablenum::AbstractString
#     tablename::AbstractString
#     tabledesc::AbstractString
#     linedesc::OrderedDict
#     tablenotes::Any
#     frequency::AbstractString
#     startyear::Int
#     endyear::Int
#     df::DataFrame
# end
#
# function Base.show(io::IO, b::BeaTable)
#     println(io, "BEA NIPA Table")
#     println(io, "Table: $(b.tablenum)")
#     println(io, "TableName: $(b.tablename)")
#     println(io, "Description: $(b.tabledesc)")
#     println(io, "Coverage: $(b.frequency), from $(b.startyear) to $(b.endyear)")
# end

include("get_bea_datasets.jl")
include("get_bea_parameterlist.jl")
# include("get_nipa_table.jl")

end # module
