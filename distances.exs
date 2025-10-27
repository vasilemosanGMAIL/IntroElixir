defmodule Distance do
  @moduledoc """
  Provides functions for calculating distances between geometric points.
  A point is represented as a tuple in the format {:point, x, y} where x and y are numbers.
  """

  @typedoc """
  Represents a 2D point with x and y coordinates.
  """
  @type point :: {:point, number(), number()}

  @doc """
  Calculates the Euclidean distance between two points.

  ## Parameters
    * point1 - First point in format {:point, x1, y1}
    * point2 - Second point in format {:point, x2, y2}

  ## Returns
    * float() - The distance between the two points
  """
  @spec distance(point(), point()) :: float()
  def distance({:point, x1, y1}, {:point, x2, y2})
      when is_number(x1) and is_number(y1) and is_number(x2) and is_number(y2) do
    x_dist = x2 - x1
    y_dist = y2 - y1
    :math.sqrt(:math.pow(x_dist, 2) + :math.pow(y_dist, 2))
  end

  def distance(point1, point2) do
    raise ArgumentError,
          "Invalid point format. Expected {:point, number, number}, got: #{inspect(point1)} and #{inspect(point2)}"
  end
end

ExUnit.start()

defmodule DistanceTest do
  use ExUnit.Case, async: true

  describe "distance/2" do
    test "calculates distance between two points on the same axis" do
      assert Distance.distance({:point, 0, 0}, {:point, 0, 100}) == 100.0
      assert Distance.distance({:point, 0, 0}, {:point, 100, 0}) == 100.0
    end

    test "calculates distance for points forming a 3-4-5 triangle" do
      assert Distance.distance({:point, 0, 0}, {:point, 3, 4}) == 5.0
    end

    test "calculates distance for points with negative coordinates" do
      assert Distance.distance({:point, -1, -1}, {:point, 2, 3}) == 5.0
    end

    test "calculates distance for decimal coordinates" do
      result = Distance.distance({:point, 1.5, 2.5}, {:point, 4.5, 6.5})
      assert_in_delta result, 5.0, 0.000001
    end

    test "returns 0.0 for same point" do
      assert Distance.distance({:point, 1, 1}, {:point, 1, 1}) == 0.0
    end

    test "raises ArgumentError for invalid point format" do
      assert_raise ArgumentError, fn ->
        Distance.distance({:invalid, 0, 0}, {:point, 1, 1})
      end

      assert_raise ArgumentError, fn ->
        Distance.distance({:point, "0", 0}, {:point, 1, 1})
      end
    end
  end
end
