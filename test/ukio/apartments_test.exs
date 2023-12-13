defmodule Ukio.ApartmentsTest do
  use Ukio.DataCase

  alias Ukio.Apartments

  describe "apartments" do
    alias Ukio.Apartments.Apartment

    import Ukio.ApartmentsFixtures
    alias Ukio.Bookings.Handlers.BookingCreator

    @invalid_attrs %{
      address: nil,
      monthly_price: nil,
      name: nil,
      square_meters: nil,
      zip_code: nil,
      market: nil,
    }

    test "list_apartments/0 returns all apartments" do
      apartment_fixture()
      assert length(Apartments.list_apartments()) == 1
    end

    test "get_apartment!/1 returns the apartment with given id" do
      apartment = apartment_fixture()
      assert Apartments.get_apartment!(apartment.id) == apartment
    end

    test "create_apartment/1 with valid data creates a apartment" do
      valid_attrs = %{
        address: "some address",
        monthly_price: 42,
        name: "some name",
        square_meters: 42,
        zip_code: "some zip_code",
        market: "earth",
      }

      assert {:ok, %Apartment{} = apartment} = Apartments.create_apartment(valid_attrs)
      assert apartment.address == "some address"
      assert apartment.monthly_price == 42
      assert apartment.name == "some name"
      assert apartment.square_meters == 42
      assert apartment.zip_code == "some zip_code"
      assert apartment.market == "earth"
    end

    test "create_apartment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Apartments.create_apartment(@invalid_attrs)
    end

    test "update_apartment/2 with valid data updates the apartment" do
      apartment = apartment_fixture()

      update_attrs = %{
        address: "some updated address",
        monthly_price: 43,
        name: "some updated name",
        square_meters: 43,
        zip_code: "some updated zip_code",
        market: "mars",
      }

      assert {:ok, %Apartment{} = apartment} =
               Apartments.update_apartment(apartment, update_attrs)

      assert apartment.address == "some updated address"
      assert apartment.monthly_price == 43
      assert apartment.name == "some updated name"
      assert apartment.square_meters == 43
      assert apartment.zip_code == "some updated zip_code"
      assert apartment.market == "mars"
    end

    test "update_apartment/2 with invalid data returns error changeset" do
      apartment = apartment_fixture()
      assert {:error, %Ecto.Changeset{}} = Apartments.update_apartment(apartment, @invalid_attrs)
      assert apartment == Apartments.get_apartment!(apartment.id)
    end

    test "delete_apartment/1 deletes the apartment" do
      apartment = apartment_fixture()
      assert {:ok, %Apartment{}} = Apartments.delete_apartment(apartment)
      assert_raise Ecto.NoResultsError, fn -> Apartments.get_apartment!(apartment.id) end
    end

    test "change_apartment/1 returns a apartment changeset" do
      apartment = apartment_fixture()
      assert %Ecto.Changeset{} = Apartments.change_apartment(apartment)
    end

    test "is_available/3 with available dates returns available" do
      apartment = apartment_fixture()
      assert {:ok, :available} = Apartments.is_available(apartment.id, ~D"2023-12-05", ~D"2023-12-06")
    end

    test "is_available/3 with unavailable dates returns unavailable" do
      apartment = apartment_fixture()
      booking_params = %{
        "check_in" => ~D"2023-12-10",
        "check_out" => ~D"2023-12-11",
        "apartment_id" => apartment.id
      }
      BookingCreator.create(booking_params)

      assert {:error, :unavailable} = Apartments.is_available(apartment.id, ~D"2023-12-10", ~D"2023-12-11")
    end
  end
end
