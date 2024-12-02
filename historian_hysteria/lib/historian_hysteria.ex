defmodule HistorianHysteria do
  def get_total_distance do
    {left_numbers, right_numbers} = read_from_file("numbers")
    ordered_left = sort(left_numbers)
    ordered_right = sort(right_numbers)

    result_list = get_list_of_distances(ordered_left, ordered_right, [])
    Enum.sum(result_list)
  end

  defp get_list_of_distances(left_numbers, right_numbers, list_of_distances) do
    if Enum.empty?(left_numbers) || Enum.empty?(right_numbers) do
      list_of_distances
    else
      min_left = Enum.min(left_numbers)
      min_right = Enum.min(right_numbers)
      distance = abs(min_left - min_right)

      list_of_distances = [distance | list_of_distances]

      left_numbers = tl(left_numbers)
      right_numbers = tl(right_numbers)
      get_list_of_distances(left_numbers, right_numbers, list_of_distances)
    end
  end

  defp sort(nums) do
    nums |> Enum.sort(:asc)
  end

  defp read_from_file(filename) do
    file_path = Path.join(__DIR__, filename)
    File.stream!(file_path)
    |> Stream.map(&String.trim/1)
    |> Stream.reject(&(&1==""))
    |>Stream.map(fn line ->
      [left_col, right_col] = String.split(line)
      {String.to_integer(left_col), String.to_integer(right_col)}
    end)
    |> Enum.unzip()
  end
end
