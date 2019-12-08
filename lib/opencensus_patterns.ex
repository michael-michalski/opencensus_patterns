defmodule OC.Patterns do
  @moduledoc """
  Documentation for OpencensusPatterns.
  """

  defmacro __using__(_opts) do
    quote do
      import OC.Patterns, only: [trace: 3, ntrace: 3, annotated_trace: 3, annotated_ntrace: 3]
      require OC.Patterns
    end
  end

  defmacro trace(function = {fname_, [line: line_], _func_args_}, ctx, do: expr) do
    fname = to_string(fname_)
    line = to_string(line_)
    quote do
      def unquote(function) do
        attributes = %{"component" => __MODULE__, "line" => unquote(line), "pid" => "#{inspect self()}"}
        unquote(ctx) = :oc_trace.start_span(unquote(fname), :ocp.current_span_ctx(), %{attributes: attributes})
        try do
          unquote(expr)
        after
          :oc_trace.finish_span(unquote(ctx))
        end
      end
    end
  end

  defmacro annotated_trace(function = {fname_, [line: line_], func_args_}, ctx, do: expr) do
    fname = to_string(fname_)
    line = to_string(line_)
    open_census_args__ = Enum.map(func_args_, fn {name, _, _} -> "#{name}" end)
    quote do
      def unquote(function) do
        attributes = %{"component" => __MODULE__, "line" => unquote(line), "pid" => "#{inspect self()}"}
        args = Enum.zip(unquote(open_census_args__), Enum.map(unquote(func_args_), fn arg -> "#{inspect arg}" end))
        |> Enum.into(%{})
        unquote(ctx) = :oc_trace.start_span(unquote(fname), :ocp.current_span_ctx(), %{attributes: Map.merge(attributes, args)} )
        try do
          unquote(expr)
        after
          :oc_trace.finish_span(unquote(ctx))
        end
      end
    end
  end

  defmacro ntrace(function = {fname_, [line: line_], func_args_}, ctx, do: expr) do
    fname = to_string(fname_)
    line = to_string(line_)
    top_ctx = List.last(func_args_)
    quote do
      def unquote(function) do
        attributes = %{"component" => __MODULE__, "line" => unquote(line), "pid" => "#{inspect self()}"}
        unquote(ctx) = :oc_trace.start_span(unquote(fname), unquote(top_ctx), %{attributes: attributes})
        try do
          unquote(expr)
        after
          :oc_trace.finish_span(unquote(ctx))
        end
      end
    end
  end

  defmacro annotated_ntrace(function = {fname_, [line: line_], func_args_}, ctx, do: expr) do
    fname = to_string(fname_)
    line = to_string(line_)
    top_ctx = List.last(func_args_)
    open_census_args__ = Enum.map(func_args_, fn {name, _, _} -> "#{name}" end)
    quote do
      def unquote(function) do
        attributes = %{"component" => __MODULE__, "line" => unquote(line), "pid" => "#{inspect self()}"}
        args = Enum.zip(unquote(open_census_args__), Enum.map(unquote(func_args_), fn arg -> "#{inspect arg}" end))
        |> Enum.into(%{})
        unquote(ctx) = :oc_trace.start_span(unquote(fname), unquote(top_ctx), %{attributes: Map.merge(attributes, args)})
        try do
          unquote(expr)
        after
          :oc_trace.finish_span(unquote(ctx))
        end
      end
    end
  end
end

