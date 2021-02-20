defmodule Softmax do
  import Nx.Defn
  defn softmax(n), do: Nx.exp(n) / Nx.sum(Nx.exp(n)) |> inspect_expr()
end

IO.inspect Softmax.softmax(Nx.tensor([1, 2, 3, 4]))
Nx.Defn.aot(&Softmax.softmax/1, [Nx.tensor([1, 2, 3, 4])], EXLA)

defmodule Softmax do
  import Nx.Defn
  @on_load :__on_load__
  def __on_load__ do
    :erlang.load_nif('./libnif', 0)
  end

  def softmax(_), do: :ok
end

IO.inspect Nx.from_binary(Softmax.softmax(<<1::64-native, 2::64-native, 3::64-native, 4::64-native>>), {:f, 64})