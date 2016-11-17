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
    |> filter_odd
    |> create_pixel_map
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
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  @doc """
  Helper function to mirror the input row.
  """
  def mirror_row(row) do
    [first, second, _nope] = row

    row ++ [second, first]
  end

  def filter_odd(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn({code, _nope}) ->
      rem(code, 2) == 0
    end

  %Identicon.Image{image | grid: grid}
  end

  @doc """
  Builds a pixel map
  """
  def create_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn({_code, index}) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50
      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}

      {top_left, bottom_right}
    end

    %Identicon.Image{image | pixel_map: pixel_map}
  end

end
