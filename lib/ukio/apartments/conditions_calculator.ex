defmodule Ukio.Apartments.ConditionsCalculator do
    
    @mars_utility_square_meters_rate 200

    def calculate(apartment) do
        case apartment.market do
            "Mars" ->
                %{
                    utilities: calculate_mars_utilities(apartment),
                    deposit: 100_000,
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
end 