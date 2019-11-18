defmodule OC.Patterns do
  @moduledoc """
  Documentation for OpencensusPatterns.
  """

  defmacro __using__(_opts) do
    quote do
      import OC.Patterns, only: [trace: 3, ntrace: 3, annotate: 2]
      require OC.Patterns
    end
  end

  defmacro trace(function = {fname_, [line: line_], _func_args_}, ctx, do: expr) do
    fname = to_string(fname_)
    line = to_string(line_)
    quote do
      def unquote(function) do
        attributes = %{component: __MODULE__, line: unquote(line), pid: "#{inspect self()}"}
        unquote(ctx) = :oc_trace.start_span(unquote(fname), :undefined, %{attributes: attributes})
        result = unquote(expr)
        :oc_trace.finish_span(unquote(ctx))
        result
      end
    end
  end

  defmacro ntrace(function = {fname_, [line: line_], func_args_}, ctx, do: expr) do
    fname = to_string(fname_)
    line = to_string(line_)
    top_ctx = List.last(func_args_)
    quote do
      def unquote(function) do
        attributes = %{component: __MODULE__, line: unquote(line), pid: "#{inspect self()}"}
        unquote(ctx) = :oc_trace.start_span(unquote(fname), unquote(top_ctx), %{attributes: attributes})
        result = unquote(expr)
        :oc_trace.finish_span(unquote(ctx))
        result
      end
    end
  end

  defmacro annotate(ctx, args) do
    arg_names = args |> Enum.map(fn {name, _,_} -> to_string name end)
    quote do
      stringified = Enum.map(unquote(args), fn arg -> "#{inspect arg}" end)
      :oc_span.annotation("", Enum.zip(unquote(arg_names), stringified) |> Enum.into(%{}))
      |> :oc_trace.add_time_event(unquote(ctx))
      unquote(args)
    end
  end
end

