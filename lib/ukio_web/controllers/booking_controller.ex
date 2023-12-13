defmodule UkioWeb.BookingController do
  use UkioWeb, :controller

  alias Ukio.Apartments
  alias Ukio.Bookings.Booking
  alias Ukio.Bookings.BookingContext
  alias Ukio.Bookings.Handlers.BookingCreator

  action_fallback UkioWeb.FallbackController

  def create(conn, %{"booking" => booking_params}) do
    case BookingCreator.create(booking_params) do
      {:ok, %Booking{} = booking} ->
        conn
        |> put_status(:created)
        |> render(:show, booking: booking)
      {:error, :unavailable} -> 
        conn
        |> put_status(:unauthorized)
        |> send_resp(401, "")
    end

  rescue ArgumentError ->
    conn
    |> put_status(:unprocessable_entity)
    |> json(%{"errors": "Unprocessable entity"})
  end

  def show(conn, %{"id" => id}) do
    booking = BookingContext.get_booking!(id)
    render(conn, :show, booking: booking)
  end
end
