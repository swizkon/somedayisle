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

alias SomedayIsle.{Repo,Journey,Pitstop,User,Traveler,Leg}

Repo.delete_all(Pitstop)
Repo.delete_all(Journey)

jonas = Repo.insert!(%User{name: "jonas", email: "jonas@jerndin.se"})

tapout = Repo.insert!(%Journey{
    name: "Complete the Tapout XT",
    description: "Yo yo yo, Mark Karpinko in the house...",
    legs: [
        %Leg {"ordinal": 1, "name": "WEEK 1: Cross Core Combat"  },
        %Leg {"ordinal": 2, "name": "WEEK 1: Strength & Force Upper + Ultimate Abs" },
        %Leg {"ordinal": 3, "name": "WEEK 1: Plyo XT" },
        %Leg {"ordinal": 4, "name": "WEEK 1: Yoga XT" },
        %Leg {"ordinal": 5, "name": "WEEK 1: Legs & Back" },
        %Leg {"ordinal": 6, "name": "WEEK 1: Sprawl & Brawl" },
        %Leg {"ordinal": 7, "name": "WEEK 1: Rest Day" }
    ]
})

Repo.insert!(%Traveler{user: jonas, journey: tapout, name: jonas.name <> ": " <> tapout.name})

# comments: [
#     %Comment{body: "Excellent!"}
#   ]