defmodule OC.Patterns do
  @moduledoc """
  Documentation for OpencensusPatterns.
  """

  defmacro __using__(_opts) do
    quote do
      import OC.Patterns, only: [trace: 2]
      require OC.Patterns
    end
  end

  defmacro trace(function, do: expr) do
    {fname, _line} = case function do
      {fname, [line: line], _} -> {to_string(fname), line}
      {fname, [line: line]} -> {to_string(fname), line}
    end
    quote do
      def unquote(function) do
        IO.inspect(unquote(fname))
        span_ctx = :oc_trace.start_span(unquote(fname), :undefined, %{attributes: %{component: __MODULE__}})
        result = unquote(expr)
        :oc_trace.finish_span(span_ctx)
        result
      end
    end
  end
end
