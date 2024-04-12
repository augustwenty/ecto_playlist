defmodule EctoPlaylist.ListItem do
  def insert_at(order_list, _list_item, nil) do
    order_list
  end

  def insert_at(order_list, list_item, index) do
    order_list
    |> List.insert_at(index - 1, list_item)
  end

  def insert_at_reject(order_list, _list_item, nil) do
    order_list
  end

  def insert_at_reject(order_list, list_item, index) do
    order_list
    |> Enum.reject(fn item -> item.id == list_item.id end)
    |> List.insert_at(index - 1, list_item)
  end

  def move_higher(list, index) do
    case index do
      nil ->
        list

      0 ->
        list

      _ ->
        pop_up(list, index)
    end
  end

  defp pop_up(list, index) do
    case List.pop_at(list, index) do
      {nil, list} ->
        list

      {item, list} ->
        List.insert_at(list, index - 1, item)
    end
  end

  def move_lower(list, index) do
    case List.pop_at(list, index) do
      {nil, list} ->
        list

      {item, list} ->
        List.insert_at(list, index + 1, item)
    end
  end

  def move_to_bottom(list, index) do
    case List.pop_at(list, index) do
      {nil, list} ->
        list

      {item, list} ->
        List.insert_at(list, Enum.count(list), item)
    end
  end

  def move_to_top(list, index) do
    case List.pop_at(list, index) do
      {nil, list} ->
        list

      {item, list} ->
        List.insert_at(list, 0, item)
    end
  end

  def remove_from_list(list, index) do
    List.pop_at(list, index)
  end

    def lower_item(order_list, list_item) do
        index = Enum.find_index(order_list, fn item -> item.id == list_item.id end)

    last_index = length(order_list) - 1

    case index do
      nil -> nil
      ^last_index -> nil
      _ -> Enum.fetch!(order_list, index + 1)
    end
  end
end
