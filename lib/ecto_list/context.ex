defmodule EctoPlaylist.Context do
  @moduledoc """
  Implements conveniences to manipulate the items order list.

  You can implement all the functions available in this module by using this module inside of the context of
  the List module.
  (Check the guides to see how)

  There are two functions in this module: `sync_order_list/1` and `reset_order_list/1`

  They both take a `List` struct that you define when calling "use".

  `sync_order_list/1` : will add missing ids to the items order list of the list.

  `reset_order_list/1` : will set the items order as the list of ids ordered by inserted date.
  """

  defmacro __using__(opts) do
    list_items_key = Keyword.get(opts, :list_items_key)
    order_key = Keyword.get(opts, :order_key)

    quote do
      alias unquote(Keyword.get(opts, :list)), as: List
      alias unquote(Keyword.get(opts, :repo)), as: Repo

      @list_items_key unquote(list_items_key)
      @order_key unquote(order_key)

      @doc """
      Hello world.

      """
      def sync_order_list(%List{} = list) do
        items = Map.get(list, @list_items_key)
        order = Map.get(list, @order_key)
        new_order = EctoPlaylist.complete_order(items, order)

        attrs = Map.put(%{}, @order_key, new_order)

        list
        |> List.changeset(attrs)
        |> Repo.update()
      end

      def reset_order_list(%List{} = list) do
        items = Map.get(list, @list_items_key)
        new_order = EctoPlaylist.missing_ids_list(items)

        attrs = Map.put(%{}, @order_key, new_order)

        list
        |> List.changeset(attrs)
        |> Repo.update()
      end
    end
  end
end
