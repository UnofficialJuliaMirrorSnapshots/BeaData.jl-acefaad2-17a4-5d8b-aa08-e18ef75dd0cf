"""
    get_bea_parameterlist(b::Bea, dataset::String) -> DataFrame

Return a `DataFrame` of parameter names and attributes for `dataset`.

Example:
```julia
julia> using BeaData

julia> pl = get_bea_parameterlist(Bea(), "NIPA"); # UserID stored in ~/.beadatarc

julia> show(pl[:, 1:2])
5×2 DataFrames.DataFrame
│ Row │ ParameterName │ ParameterDescription                                           │
│     │ String        │ String                                                         │
├─────┼───────────────┼────────────────────────────────────────────────────────────────┤
│ 1   │ Frequency     │ A - Annual, Q-Quarterly, M-Monthly                             │
│ 2   │ ShowMillions  │ A flag indicating that million-dollar data should be returned. │
│ 3   │ TableID       │ The standard NIPA table identifier                             │
│ 4   │ TableName     │ The new NIPA table identifier                                  │
│ 5   │ Year          │ List of year(s) of data to retrieve (X for All)                │
```
You can get names and descriptions of accessible datasets with the [`get_bea_datasets`](@ref) function.
"""
function get_bea_parameterlist(b::Bea, dataset::String)
    url = b.url
    user_id = b.UserID
    bea_method = "GetParameterList"

    querydict = Dict("UserID" => user_id,
                     "Method" => bea_method,
                     "DatasetName" => dataset,
                     "ResultFormat" => "JSON")

    r = HTTP.request("GET", url, query = querydict)
    r_body = String(r.body)
    r_json = JSON.parse(r_body)
    if haskey(r_json["BEAAPI"]["Results"], "Error")
        error(r_json["BEAAPI"]["Results"]["Error"]["APIErrorDescription"])
    end
    r_dict = r_json["BEAAPI"]["Results"]["Parameter"]

    nparams = length(r_dict)
    parameter_id = Array{String}(undef, nparams)
    parameter_desc = Array{String}(undef, nparams)
    parameter_req = Array{String}(undef, nparams)
    default_value = Array{String}(undef, nparams)
    for i = 1:nparams
        parameter_id[i] = r_dict[i]["ParameterName"]
        parameter_desc[i] = r_dict[i]["ParameterDescription"]
        parameter_req[i] = r_dict[i]["ParameterIsRequiredFlag"]
        if haskey(r_dict[i], "ParameterDefaultValue")
            default_value[i] = r_dict[i]["ParameterDefaultValue"]
        else
            default_value[i] = ""
        end
    end

    return DataFrame(ParameterName = parameter_id, ParameterDescription = parameter_desc,
        ParamaterRequired = parameter_req, ParameterDefaultValue = default_value)
end
