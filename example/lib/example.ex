defmodule Example do
  @moduledoc """
  Documentation for Example.
  """

  use OC.Patterns

  trace top(a, b), ctx do
    annotate(a, ctx)
    annotate(b, ctx)
    lower(a, b, ctx)
  end

  ntrace lower(a, b, parent_ctx), ctx do
    a <> b
    |> annotate(ctx)
  end
end
