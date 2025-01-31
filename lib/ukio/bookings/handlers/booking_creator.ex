defmodule Ukio.Bookings.Handlers.BookingCreator do
  alias Ukio.Apartments.ApartmentContext
  alias Ukio.Bookings.BookingContext
  alias Ukio.Apartments.ConditionsCalculator

  def create(
        %{"check_in" => check_in, "check_out" => check_out, "apartment_id" => apartment_id}
      ) do
    with a <- ApartmentContext.get_apartment!(apartment_id),
         b <- generate_booking_data(a, check_in, check_out) do
      case ApartmentContext.is_available(apartment_id, check_in, check_out) do
        {:ok, :available} ->
          BookingContext.create_booking(b)
        {:error, :unavailable} -> 
          {:error, :unavailable}
      end
    end
  end

  defp generate_booking_data(apartment, check_in, check_out) do
    conditions = ConditionsCalculator.calculate(apartment)
    %{
      apartment_id: apartment.id,
      check_in: check_in,
      check_out: check_out,
      monthly_rent: apartment.monthly_price,
      utilities: conditions.utilities,
      deposit: conditions.deposit
    }
  end
end
