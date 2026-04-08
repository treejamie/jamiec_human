defmodule Jamie.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @statuses [:draft, :published, :hidden]
  @required_fields [:status, :description, :title, :markdown]
  @optional_fields [:html]

  schema "blog_posts" do
    field :status, Ecto.Enum, values: @statuses, default: :draft

    field :title, :string
    field :description, :string
    field :markdown, :string
    field :html, :string

    timestamps()
  end

  def statuses, do: @statuses

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> convert_markdown_to_html()
  end

  defp convert_markdown_to_html(changeset) do
    case get_change(changeset, :markdown) do
      nil ->
        changeset

      markdown ->
        html =
          MDEx.to_html!(markdown,
            extension: [
              strikethrough: true,
              tagfilter: true,
              table: true,
              autolink: true,
              tasklist: true,
              header_ids: ""
            ],
            parse: [smart: true],
            render: [unsafe_: true]
          )

        put_change(changeset, :html, html)
    end
  end
end
