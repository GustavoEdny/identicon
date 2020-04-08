defmodule Identicon do
  @moduledoc """
    A tool that creates user profile icons like github profile icons
  """

  def main(input) do
    input
    |> Identicon.hash_input
    |> Identicon.pick_color
    |> Identicon.build_grid
  end

  def build_grid(image) do
    grid =
      Enum.chunk(image.hex, 3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    # [165, 22, 10]
    [first, second | _tail] = row

    # [165, 22, 10, 22, 165]
    row ++ [second, first]
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end
end
