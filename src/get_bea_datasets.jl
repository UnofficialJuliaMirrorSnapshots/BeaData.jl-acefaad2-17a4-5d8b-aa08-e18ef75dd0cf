"""
    get_bea_datasets(b::Bea) -> DataFrame

Return a `DataFrame` of names and descriptions for datasets accessible through the BEA data API.

Example:
```julia
julia> using BeaData

julia> ds = get_bea_datsets(Bea()); # UserID stored in ~/.beadatarc

julia> show(ds[1:3,:])
3×2 DataFrame
│ Row │ DatasetName        │ Description                          │
│     │ String             │ String                               │
├─────┼────────────────────┼──────────────────────────────────────┤
│ 1   │ NIPA               │ Standard NIPA tables                 │
│ 2   │ NIUnderlyingDetail │ Standard NI underlying detail tables │
│ 3   │ MNE                │ Multinational Enterprises            │
```
"""
function get_bea_datasets(b::Bea)
    excluded_sets = ["RegionalData", "APIDatasetMetaData"]
    url = API_URL
    user_id = b.UserID
    bea_method = "GetDataSetList"

    querydict = Dict("UserID" => user_id,
                     "Method" => bea_method,
                     "ResultFormat" => "JSON")

    r = HTTP.request("GET", url, query = querydict)
    r_body = String(r.body)
    r_json = JSON.parse(r_body)
    if haskey(r_json["BEAAPI"]["Results"], "Error")
        error(r_json["BEAAPI"]["Results"]["Error"]["APIErrorDescription"])
    end
    r_dict = r_json["BEAAPI"]["Results"]["Dataset"]

    ids = [d["DatasetName"] for d in r_dict if d["DatasetName"] ∉ excluded_sets]
    descriptions = [d["DatasetDescription"] for d in r_dict if d["DatasetName"] ∉ excluded_sets]

    return DataFrame(DatasetName = ids, Description = descriptions)
end
