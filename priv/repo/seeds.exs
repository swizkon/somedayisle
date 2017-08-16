# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SomedayIsle.Repo.insert!(%SomedayIsle.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias SomedayIsle.Journey

tapout = SomedayIsle.Repo.insert!(%Journey{
    name: "Complete the TapouT XT challenge",
    description: "Yo uo yo, MArk Karpinko in the house" 
})
