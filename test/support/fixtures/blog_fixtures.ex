defmodule Jamie.Support.BlogFixtures do
  @moduledoc """
  Fixtures for the blog context.
  """

  @default_attrs [
    title: "Basic blog post",
    description: "A lovely description",
    markdown: """
    # Hello, World!
    Here's a list of some great ideas
    * test the thing
    * deploy the thing
    * use the thing
    """,
    status: :draft
  ]

  def blog_attrs(opts \\ []) do
    @default_attrs
    |> Keyword.merge(opts)
    |> Map.new()
  end
end
