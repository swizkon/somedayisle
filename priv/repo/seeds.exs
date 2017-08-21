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

alias SomedayIsle.{Repo,Journey,Pitstop}

Repo.delete_all(Pitstop)
Repo.delete_all(Journey)

tapout = Repo.insert!(%Journey{
    name: "Complete the TapouT XT",
    description: "Yo yo yo, Mark Karpinko in the house...",
    pitstops: [
        %Pitstop {"ordinal": 1, "title": "WEEK 1: Cross Core Combat"  },
        %Pitstop {"ordinal": 2, "title": "WEEK 1: Strength & Force Upper + Ultimate Abs" },
        %Pitstop {"ordinal": 3, "title": "WEEK 1: Plyo XT" },
        %Pitstop {"ordinal": 4, "title": "WEEK 1: Yoga XT" },
        %Pitstop {"ordinal": 5, "title": "WEEK 1: Legs & Back" },
        %Pitstop {"ordinal": 6, "title": "WEEK 1: Sprawl & Brawl" },
        %Pitstop {"ordinal": 7, "title": "WEEK 1: Rest Day" }
    ]
})

# comments: [
#     %Comment{body: "Excellent!"}
#   ]