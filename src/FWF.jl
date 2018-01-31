__precompile__(true)
module FWF

using DataStreams, Missings, DataFrames

struct ParsingException <: Exception
    msg::String
end

"""
Configuration Settings for fixed width file parsing.

  * `skip`: integer of the number of lines to skip; default `0`
  * `trimstrings`: true if strings should be trimmed; default `true`
  * `missingcheck`: true if fields should be checked for null values; default `true`
  * `missingvals`: Dictionary in form of String=>true for values that equal missing
  * ``
"""

struct Options
    missingcheck::Bool
    trimstrings::Bool
    skip::Int
    missingvals::Dict{String, Missing}
    dateformats::Dict{Int, DateFormat}
    columnrange::Vector{UnitRange{Int}}
end

 Options(;missingcheck=true, 
        trimstrings=true, skip=0, 
        missingvals=Dict{String, Missing}(), 
        dateformats=Dict{Int, DateFormat}(),
        columnrange=Vector{UnitRange{Int}}()) =
    Options(missingcheck, trimstrings, skip, missingvals, 
            dateformats, columnrange)

function Base.show(io::IO, op::Options)
    println(io, "   FWF.Options:")
    println(io, "     nullcheck: ", op.missingcheck)
    println(io, "   trimstrings: ", op.trimstrings)
    println(io, "          skip: ", op.skip)
    println(io, "   missingvals:", )
    show(io, op.missingvals)
    println(io)
    println(io, "   dateformats:")
    show(io, op.dateformats)
    println(io)
    println(io, "   columnranges:")
    show(io, op.columnrange)
    println(io)
end

include("Source.jl")
include("parsefields.jl")
#include("float.jl")
include("io.jl")
#include("TransposedSource.jl")
#include("Sink.jl")
#include("validate.jl")

end
