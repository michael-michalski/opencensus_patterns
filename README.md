# OpenCensus Patterns

![Hex.pm](https://img.shields.io/hexpm/v/opencensus_patterns.svg)

Utility functions for avoiding an entanglement ofbusiness logic and tracing.

## How to use

Example of tracing a phoenix endpoint.
```elixir
# Top level function uses the trace keyword, and .
trace home(conn, params), ctx do
  IO.puts "I am a top level function call."

  # Dumps the structure as an annotation
  annotate(params, ctx)

  # Call the nested function
  utility(conn, params, ctx)
end

# Consecutive tracing is done with the ntrace keyword,
# and the last parameter is the parent context.
ntrace utility(conn, params, parent_ctx), ctx do
  IO.puts "I am nested"
end
```

## Installation

The package is [available in Hex](https://hex.pm/docs/publish), and can be installed
by adding `opencensus_patterns` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:opencensus_patterns, "~> 0.2.0"}
  ]
end
```
