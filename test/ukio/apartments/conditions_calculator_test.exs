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

    describe "ConditionsCalculator deposit" do
        test "earth apartment's deposit is 100_000" do
            apartment = apartment_fixture(%{market: "Earth"})

            conditions = ConditionsCalculator.calculate(apartment)

            assert conditions.deposit == 100_000
        end

        test "mars apartment's utilities is a full month rent" do
            apartment = apartment_fixture(%{market: "Mars", monthly_price: 80_000})

            conditions = ConditionsCalculator.calculate(apartment)

            assert conditions.deposit == 80_000
        end
    end
end