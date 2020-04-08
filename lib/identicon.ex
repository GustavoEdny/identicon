defmodule Identicon do
  @moduledoc """
    A tool that creates user profile icons like github profile icons
  """

  def main(input) do
    input
    |> Identicon.hash_input
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end
end
