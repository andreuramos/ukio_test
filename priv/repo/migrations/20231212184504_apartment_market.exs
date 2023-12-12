defmodule Ukio.Repo.Migrations.ApartmentMarket do
  use Ecto.Migration

  def change do
    alter table(:apartments) do
      add :market, :string
    end
  end
end
