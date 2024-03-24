# Tutorial

The goal of this tutorial is to explain you how to setup ecto_playlist.
We will use a basic example to make the process clearer. We will build a simple Playlist/Scheme app, it will be called... **drum roll 🥁** ... Splashlight .
A Playlist is a set of Schemes with a certain order.

### 1) Generating the model

We will run the generators for our models: Playlists and Schemes.

mix phx.gen.html Playlists Playlist Playlists title order:array:id
mix phx.gen.html Schemes Scheme Schemes title Playlist_id:references:Playlists

We will store the Schemes order inside the Playlist with the field `:order`. In this example, we decide to call it "order" but you can change the name as you wish.
Also, we didn't care much about the name of the context so we created a separate context for each model but you could definitely put them together in the same context.

### 2) Run migration

Run the migration with `mix ecto.migrate`.
Add the following lines in the router:

```elixir
resources "/Playlists", PlaylistController
resources "/Schemes", SchemeController
```

### 3) Change schemas

Add the right relationships to the models. In the Playlist schema module `Splashlight.Playlists.Playlist`, add a default to order:

```diff
defmodule Splashlight.Playlists.Playlist do
# ...
+ alias Splashlight.Schemes.Scheme

  schema "lists" do
    field :title, :string
-   field :order, {:array, :id}
+   field :order, {:array, :id}, default: []

+   has_many :Schemes, Scheme

    timestamps()
  end

  @doc false
  def changeset(Scheme, attrs) do
    Scheme
-    |> cast(attrs, [:title])
-    |> validate_required([:title])
+    |> cast(attrs, [:title, :playlist_id])
+    |> validate_required([:title, :playlist_id])
  end

end
```

```diff
defmodule Splashlight.Schemes.Scheme do
# ...
+ alias Splashlight.Playlists.Playlist

  schema "Schemes" do
    field :title, :string
-   field :Playlist_id, :id

+   belongs_to :Playlist, Playlist

    timestamps()
  end
# ...
end
```

### 4) Install `ecto_playlist`

Add `ecto_playlist` to your list of dependencies in `mix.exs` (you can check the last version on hex.pm).

```elixir
def deps do
  [
    # ...
    {:ecto_playlist, "~> 0.0.1"}
    # ...
  ]
end
```

### 5) use `EctoList.Context`

You can use the EctoList.Context module to add Context functions to the Playlist Context.

```diff
defmodule Splashlight.Playlists do
  @moduledoc """
  The Playlists context.
  """

  import Ecto.Query, warn: false
  alias Splashlight.Repo

  alias Splashlight.Playlists.Playlist

+ use EctoList.Context,
+   list: Playlist,
+   repo: Repo,
+   list_items_key: :Schemes,
+   order_key: :order
```

Options:

- `list`: the schema containing the list of items. Here it is Playlist because each Playlist can contain a list of Schemes.
- `repo`: the Repo module of the app
- `list_items_key`: the key used in the `has_many` relationship to access the list of items
- `order_key`: the key used in the field that contains the items order. Here it's `order` because that's how we decided to call it.

### 6) Preload Schemes

Add `Repo.preload/2` to load the Schemes while fetching for a specific Playlist.

```diff
- def get_Playlist!(id), do: Repo.get!(Playlist, id)
+ def get_Playlist!(id), do: Repo.get!(Playlist, id) |> Repo.preload(:Schemes)
```

## Conclusion

There is still a lot of code copy pasting but it's worth it because you have the control of your code.
This library is pretty basic. The most important function is `EctoList.ordered_items_list/2` that render the list of items in the appropriate order.
