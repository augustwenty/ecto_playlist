defmodule EctoListItemTest do
  use ExUnit.Case
  doctest EctoPlaylist

  @all_items [
    %{id: 1, title: "Item 1", inserted_at: ~N[2019-07-16 16:03:15]},
    %{id: 2, title: "Item 2", inserted_at: ~N[2019-07-16 16:04:15]},
    %{id: 3, title: "Item 3", inserted_at: ~N[2019-07-16 16:05:15]},
    %{id: 4, title: "Item 4", inserted_at: ~N[2019-07-16 16:06:15]},
    %{id: 5, title: "Item 5", inserted_at: ~N[2019-07-16 16:07:15]}
  ]

  test "ordered_items_list/2" do
  new_list = EctoPlaylist.ListItem.insert_at(@all_items, %{id: 6, title: "Item 6", inserted_at: ~N[2019-07-16 16:07:15]}, 1)
  assert [
               %{id: 6, title: "Item 6", inserted_at: ~N[2019-07-16 16:07:15]},
               %{id: 6, title: "Item 6", inserted_at: ~N[2019-07-16 16:07:15]},
               %{id: 1, title: "Item 1", inserted_at: ~N[2019-07-16 16:03:15]},
               %{id: 2, title: "Item 2", inserted_at: ~N[2019-07-16 16:04:15]},
               %{id: 3, title: "Item 3", inserted_at: ~N[2019-07-16 16:05:15]},
               %{id: 4, title: "Item 4", inserted_at: ~N[2019-07-16 16:06:15]},
               %{id: 5, title: "Item 5", inserted_at: ~N[2019-07-16 16:07:15]}
             ] ==
  EctoPlaylist.ListItem.insert_at(new_list, %{id: 6, title: "Item 6", inserted_at: ~N[2019-07-16 16:07:15]}, 1)
  end

end
