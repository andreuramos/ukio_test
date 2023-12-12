defmodule Ukio.Apartments.ConditionsCalculatorTest do
    use Ukio.DataCase
    import Ukio.ApartmentsFixtures
    alias Ukio.Apartments.ConditionsCalculator

    describe "ConditionsCalculator utilities" do
        test "earth apartment's utilities is 20_000" do
            apartment = apartment_fixture(%{market: "Earth"})

            conditions = ConditionsCalculator.calculate(apartment)

            assert conditions.utilities == 20_000
        end

        test "mars apartment's utilities is linked to the square meters" do
            apartment = apartment_fixture(%{market: "Mars", square_meters: 60})

            conditions = ConditionsCalculator.calculate(apartment)

            assert conditions.utilities == 12_000
        end
    end
end