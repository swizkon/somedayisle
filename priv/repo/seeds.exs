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

alias SomedayIsle.{Journey,Pitstop}

tapout = SomedayIsle.Repo.insert!(%Journey{
    name: "Complete the TapouT XT",
    description: "Yo yo yo, Mark Karpinko in the house...",
    pitstops: [
        %Pitstop { "title": "WEEK 1: Cross Core Combat" },
        %Pitstop { "title": "WEEK 1: Strength & Force Upper + Ultimate Abs" },
        %Pitstop { "title": "WEEK 1: Plyo XT" },
        %Pitstop { "title": "WEEK 1: Yoga XT" },
        %Pitstop { "title": "WEEK 1: Legs & Back" },
        %Pitstop { "title": "WEEK 1: Sprawl & Brawl" },
        %Pitstop { "title": "WEEK 1: Rest Day" }
    ]
})

# comments: [
#     %Comment{body: "Excellent!"}
#   ]