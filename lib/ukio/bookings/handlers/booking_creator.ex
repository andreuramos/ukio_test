defmodule Ukio.Bookings.Handlers.BookingCreator do
  alias Ukio.Apartments

  def create(
        %{"check_in" => check_in, "check_out" => check_out, "apartment_id" => apartment_id}
      ) do
    with a <- Apartments.get_apartment!(apartment_id),
         b <- generate_booking_data(a, check_in, check_out) do
      case Apartments.is_available(apartment_id, check_in, check_out) do
        {:ok, :available} ->
          Apartments.create_booking(b)
        {:error, :unavailable} -> 
          {:error, :unavailable}
      end
    end
  end

  defp generate_booking_data(apartment, check_in, check_out) do
    %{
      apartment_id: apartment.id,
      check_in: check_in,
      check_out: check_out,
      monthly_rent: apartment.monthly_price,
      utilities: 20_000,
      deposit: 100_000
    }
  end
end
