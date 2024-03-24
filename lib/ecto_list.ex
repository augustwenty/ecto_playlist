defmodule EctoPlaylist do
  @moduledoc """
  Implements conveniences to handle the items order of a list.
  """

  @doc """
  Returns the list of items ordered according to the order list.

  If ids are missing in order, the items will be ordered according to their inserted date.

  ## Examples

      all_items = [%{id: 1, title: "Item 1", inserted_at: ~N[2019-07-16 16:03:15]},
          %{id: 2, title: "Item 2", inserted_at: ~N[2019-07-16 16:04:15]},
          %{id: 3, title: "Item 3", inserted_at: ~N[2019-07-16 16:05:15]},
          %{id: 4, title: "Item 4", inserted_at: ~N[2019-07-16 16:06:15]},
          %{id: 5, title: "Item 5", inserted_at: ~N[2019-07-16 16:07:15]}]

      order = [5, 3, 1]

      ordered_items_list(all_items, order)
      # [%{id: 5, title: "Item 5", inserted_at: ~N[2019-07-16 16:07:15]},
      #    %{id: 3, title: "Item 3", inserted_at: ~N[2019-07-16 16:05:15]},
      #    %{id: 1, title: "Item 1", inserted_at: ~N[2019-07-16 16:03:15]},
      #    %{id: 2, title: "Item 2", inserted_at: ~N[2019-07-16 16:04:15]},
      #    %{id: 4, title: "Item 4", inserted_at: ~N[2019-07-16 16:06:15]}]

  """
  def ordered_items_list(items, order \\ []) do
    complete_order = complete_order(items, order)

    search_function = fn x -> Enum.find(items, fn item -> item.id == x end) end

    Enum.map(complete_order, search_function)
    |> Enum.filter(&(!is_nil(&1)))
  end

  @doc """
  Returns the list of ids composed of the current list order + all the missings ids ordered by insertion date.

  ## Examples

      all_items = [%{id: 1, title: "Item 1", inserted_at: ~N[2019-07-16 16:03:15]},
          %{id: 2, title: "Item 2", inserted_at: ~N[2019-07-16 16:04:15]},
          %{id: 3, title: "Item 3", inserted_at: ~N[2019-07-16 16:05:15]},
          %{id: 4, title: "Item 4", inserted_at: ~N[2019-07-16 16:06:15]},
          %{id: 5, title: "Item 5", inserted_at: ~N[2019-07-16 16:07:15]}]

      order = [5, 3, 1]

      complete_order(all_items, order)
      # [5, 3, 1, 2, 4]

  """

  def complete_order(items, nil), do: complete_order(items, [])

  def complete_order(items, order) do
    missing_ids_list = missing_ids_list(items, order)

    order ++ missing_ids_list
  end

  @doc """
  Same as `missing_ids_list/2` but returns all ids ordered by insertion date.
  """
  def missing_ids_list(all_items), do: missing_ids_list(all_items, [])

  @doc """
  Returns the list of missing ids ordered by insertion date.

  ## Examples

      all_items = [%{id: 1, title: "Item 1", inserted_at: ~N[2019-07-16 16:03:15]},
          %{id: 2, title: "Item 2", inserted_at: ~N[2019-07-16 16:04:15]},
          %{id: 3, title: "Item 3", inserted_at: ~N[2019-07-16 16:05:15]},
          %{id: 4, title: "Item 4", inserted_at: ~N[2019-07-16 16:06:15]},
          %{id: 5, title: "Item 5", inserted_at: ~N[2019-07-16 16:07:15]}]

      order = [5, 3, 1]

      missing_ids_list(all_items, order)
      # [2, 4]

  """
  def missing_ids_list(all_items, nil), do: missing_ids_list(all_items, [])

  def missing_ids_list(all_items, order) do
    all_items
    |> sorted_items_by_inserted_date
    |> Enum.reduce([], fn x, acc ->
      if !Enum.member?(order ++ acc, x.id) do
        acc ++ [x.id]
      else
        acc
      end
    end)
  end

  defp sorted_items_by_inserted_date(items) do
    items
    |> Enum.sort(&(NaiveDateTime.compare(&1.inserted_at, &2.inserted_at) == :lt))
  end
end
