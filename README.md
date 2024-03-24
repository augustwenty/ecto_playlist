# ecto_playlist

Ecto_playlist is a simple library that helps you manage ordered model with Ecto.

## Description

Let's take an example of an ordered model: a Playlist which contains an ordered list of Schemes.

Instead of storing the position of each scheme in the schemes themselves, we will store the ordering in the playlist and we will call `EctoPlaylist.ordered_items_list/2` to return for us the list of items properly ordered.

## Installation

Read the [tutorial](guides/tutorial.md) to understand the process of installation of the library.

## Functions available

In `EctoPlaylist.ListItem`, you have a set of functions to modify the ordering of your order list.

#### Functions That Change Position and Reorder List

- `EctoPlaylist.ListItem.insert_at/3`
- `EctoPlaylist.ListItem.move_lower/2` will do nothing if the item is the lowest item
- `EctoPlaylist.ListItem.move_higher/2` will do nothing if the item is the highest item
- `EctoPlaylist.ListItem.move_to_bottom/2`
- `EctoPlaylist.ListItem.move_to_top/2`
- `EctoPlaylist.ListItem.remove_from_list/2`

#### Methods That Return Data of the Item's List Position

- `EctoPlaylist.ListItem.first?/2`
- `EctoPlaylist.ListItem.last?/2`
- `EctoPlaylist.ListItem.in_list?/2`
- `EctoPlaylist.ListItem.not_in_list?/2`
- `EctoPlaylist.ListItem.higher_item/2`
- `EctoPlaylist.ListItem.higher_items/2` will return all the ids above the given list item id in the order_list
- `EctoPlaylist.ListItem.lower_item/2`
- `EctoPlaylist.ListItem.lower_items/2` will return all the ids below the given list item id in the order_list

## Documentation

The documentation can be found here: [https://hexdocs.pm/ecto_playlist](https://hexdocs.pm/ecto_playlist).