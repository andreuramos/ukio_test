defmodule UkioWeb.ApartmentController do
  use UkioWeb, :controller

  alias Ukio.Apartments.ApartmentContext

  action_fallback UkioWeb.FallbackController

  def index(conn, _params) do
    apartments = ApartmentContext.list_apartments()
    render(conn, :index, apartments: apartments)
  end
end
