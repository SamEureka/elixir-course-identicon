defmodule Identicon do
  @moduledoc """
  Creates an Identicon from an input string.
  """

  @doc """
  Creates the Identicon.
  """
  def main(input) do
    input
    |> create_hash
    |> create_color
    |> create_grid
  end

  @doc """
  Calculates a hash of the input string using MD5.
  """
  def create_hash(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

  @doc """
  Creates a color from the first three hex values in the hash.
  """
  def create_color(%Identicon.Image{hex: [r, g, b | _nope]} = image) do

    %Identicon.Image{image | color: {r, g, b}}
  end

  @doc """
  Builds a number grid from the hex values.
  """
  def create_grid(%Identicon.Image{hex: hex} = image) do
    hex
    |> Enum.chunk(3)
    |> Enum.map(&mirror_row/1)
  end

  @doc """
  Helper function to mirror the input row.
  """
  def mirror_row(row) do
    [first, second, _nope] = row

    row ++ [second, first]
  end

end
