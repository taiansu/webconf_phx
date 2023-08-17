defmodule WebconfPhxWeb.SumLive.Index do
  use WebconfPhxWeb, :live_view

  # 1. `mount/3` is the entrance of the liveivew websocket connection
  @imple true
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(prev: nil, result: nil)
      |> assign(form: to_form(%{"to" => nil}))
    }
  end

  # 2. `render/1` use Heex to describe what should we display on the screen.
  # 
  # Btw, we can extract these into a `index.html.heex` file if the function gets too long.
  @imple true
  def render(assigns) do
    ~H"""
    <!-- 3. notice the value of phx-submit, which lead us to the calc/2 function -->
    <.form id="sum" for={@form} phx-debounce="200" phx-submit="calc" class="pb-5">
      <.input type="number" field={@form[:to]} />
    </.form>
    <div :if={@result}>
      <h1 class="text-3xl font-bold">∑ 1..<%= @prev %> = <%= @result %></h1>
    </div>
    """
  end

  def handle_event("calc", %{"to" => to}, socket) do
    result = to |> String.to_integer() |> calc(0)

    {
      :noreply,
      socket
      |> assign(form: to_form(%{"to" => nil}))
      |> assign(prev: to, result: result)
    }
  end

  # 4. from here to line 49 is where we recursively do the calculation
  defp calc(0, accu) do
    accu
  end

  defp calc(to, accu) do
    calc(to - 1, accu + to)
  end
end
