defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, session, socket) do
    {:ok,
     assign(
       socket,
       score: 0,
       win_guess: Enum.random(1..10),
       message: "Make a guess:",
       time: time(),
       session_id: session["live_socket_id"]
     )}
  end

  def render(assigns) do
    ~H"""
    <h1 class="mb-4 text-4xl font-extrabold">
      Your Score: <%= @score %>
    </h1>
    <h2>
      <%= @message %> It's <%= @time %>
    </h2>
    <br />
    <h2 class="mb-4">
      <.link
        :for={n <- 1..10}
        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 border border-blue-700 rounded-m-1"
        phx-click="guess"
        phx-value-number={n}
      >
        <%= n %>
      </.link>
    </h2>
    <pre>
      <%= @current_user.email %>
      <%= @session_id %>
    </pre>
    """
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    socket =
      if socket.assigns.win_guess == String.to_integer(guess) do
        assign(socket,
          score: socket.assigns.score + 1,
          message: "Your guess: #{guess}. Right guess"
        )
      else
        assign(socket,
          score: socket.assigns.score - 1,
          message: "Your guess: #{guess}. Wrong guess"
        )
      end

    socket =
      assign(
        socket,
        win_guess: Enum.random(1..10),
        time: time()
      )

    {:noreply, socket}
  end

  defp time() do
    DateTime.utc_now() |> to_string()
  end
end
