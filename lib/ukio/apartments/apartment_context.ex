defmodule Ukio.Apartments.ApartmentContext do
  @moduledoc """
  The Apartments context.
  """

  import Ecto.Query, warn: false
  alias Ukio.Repo

  alias Ukio.Apartments.Apartment
  alias Ukio.Bookings.Booking

  @doc """
  Returns the list of apartments.

  ## Examples

      iex> list_apartments()
      [%Apartment{}, ...]

  """
  def list_apartments do
    Repo.all(Apartment)
  end

  @doc """
  Gets a single apartment.

  Raises `Ecto.NoResultsError` if the Apartment does not exist.

  ## Examples

      iex> get_apartment!(123)
      %Apartment{}

      iex> get_apartment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_apartment!(id), do: Repo.get!(Apartment, id)

  @doc """
  Creates a apartment.

  ## Examples

      iex> create_apartment(%{field: value})
      {:ok, %Apartment{}}

      iex> create_apartment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_apartment(attrs \\ %{}) do
    %Apartment{}
    |> Apartment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a apartment.

  ## Examples

      iex> update_apartment(apartment, %{field: new_value})
      {:ok, %Apartment{}}

      iex> update_apartment(apartment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_apartment(%Apartment{} = apartment, attrs) do
    apartment
    |> Apartment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a apartment.

  ## Examples

      iex> delete_apartment(apartment)
      {:ok, %Apartment{}}

      iex> delete_apartment(apartment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_apartment(%Apartment{} = apartment) do
    Repo.delete(apartment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking apartment changes.

  ## Examples

      iex> change_apartment(apartment)
      %Ecto.Changeset{data: %Apartment{}}

  """
  def change_apartment(%Apartment{} = apartment, attrs \\ %{}) do
    Apartment.changeset(apartment, attrs)
  end

  @doc """
  Checks if apartment is available for the given dates
  """
  def is_available(apartment_id, check_in, check_out) do
    query = from b in Booking,
      where: b.apartment_id == ^apartment_id,
      where: ((b.check_in <= ^check_in and b.check_out > ^check_in) or
             (b.check_in < ^check_out and b.check_out >= ^check_out) or
             (b.check_in >= ^check_in and b.check_out <= ^check_out)),
      select: b.id
    
    bookings = Repo.all(query)
    if Enum.empty?(bookings) do
      {:ok, :available}
    else
      {:error, :unavailable}
    end
    
  end
end
