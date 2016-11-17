defmodule Identicon.Image do
  @moduledoc """
  Defines Image struct
  """

  @doc """
  | Key      | Init value |
  |----------|------------|
  |hex:      |nil         |
  |color:    |nil         |
  |grid:     |nil         |
  |pixel_map:|nil         |
  """
  defstruct hex: nil, color: nil, grid: nil, pixel_map: nil
end
