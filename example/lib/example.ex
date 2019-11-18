defmodule Example do
  @moduledoc """
  Documentation for Example.
  """

  use OC.Patterns

  trace top(a, b), ctx do
    # annotate(ctx, a)
    # annotate(ctx, b)
    lower(a, b, ctx)
  end

  ntrace lower(a, b, parent_ctx), ctx do
    a <> b
    #|> annotate(ctx)
  end
end
