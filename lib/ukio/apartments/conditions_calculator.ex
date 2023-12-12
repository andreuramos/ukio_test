defmodule Ukio.Apartments.ConditionsCalculator do
    
    @mars_utility_square_meters_rate 200

    def calculate(apartment) do
        case apartment.market do
            "Mars" ->
                %{
                    utilities: calculate_mars_utilities(apartment),
                    deposit: calculate_mars_deposit(apartment),
                }
            _ ->
                %{
                    utilities: 20_000,
                    deposit: 100_000,
                }
        end
    end

    defp calculate_mars_utilities(apartment) do
        utilities = apartment.square_meters * @mars_utility_square_meters_rate

        utilities
    end

    defp calculate_mars_deposit(apartment) do
        apartment.monthly_price
    end
end 