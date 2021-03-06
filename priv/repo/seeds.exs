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

alias SomedayIsle.{Repo,Journey,User,Traveler,Leg,LegState,TravelPlan}

defmodule DatabaseSeeder do

    def completed_leg user, leg do
        %LegState{
            leg_id: leg,
            user_id: user,
            status: "Completed"
        }
    end

    def incomplete_leg user, leg do
        %LegState{
            leg_id: leg,
            user_id: user,
            status: "Incomplete"
        }
    end
end

Repo.delete_all(Traveler)
Repo.delete_all(LegState)
Repo.delete_all(Leg)
Repo.delete_all(Journey)
Repo.delete_all(User)


jonas = Repo.insert!(%User{name: "jonas", email: "mail@somedayisle.net"})

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
        %Leg {"ordinal": 7, "name": "WEEK 1: Rest Day" },

        %Leg {"ordinal":  8, "name": "WEEK 2: Competition Core" },
        %Leg {"ordinal":  9, "name": "WEEK 2: Strength & Force Upper + Ultimate Abs" },
        %Leg {"ordinal": 10, "name": "WEEK 2: Plyo XT" },
        %Leg {"ordinal": 11, "name": "WEEK 2: Yoga XT" },
        %Leg {"ordinal": 12, "name": "WEEK 2: Legs & Back" },
        %Leg {"ordinal": 13, "name": "WEEK 2: Cardio XT + Ultimate Abs" },
        %Leg {"ordinal": 14, "name": "WEEK 2: Rest Day" },

        %Leg {"ordinal": 15, "name": "WEEK 3: Cross Core Combat" },
        %Leg {"ordinal": 16, "name": "WEEK 3: Strength & Force Upper + Ultimate Abs" },
        %Leg {"ordinal": 17, "name": "WEEK 3: Plyo XT" },
        %Leg {"ordinal": 18, "name": "WEEK 3: Yoga XT" },
        %Leg {"ordinal": 19, "name": "WEEK 3: Legs & Back" },
        %Leg {"ordinal": 20, "name": "WEEK 3: Sprawl & Brawl" },
        %Leg {"ordinal": 21, "name": "WEEK 3: Rest Day" },
        
        %Leg {"ordinal": 22, "name": "WEEK 4: Competition Core" },
        %Leg {"ordinal": 23, "name": "WEEK 4: Buns & Guns + Ultimate Abs" },
        %Leg {"ordinal": 24, "name": "WEEK 4: Muay Thai" },
        %Leg {"ordinal": 25, "name": "WEEK 4: Yoga XT" },
        %Leg {"ordinal": 26, "name": "WEEK 4: Sprawl & Brawl" },
        %Leg {"ordinal": 27, "name": "WEEK 4: Cardio XT + Ultimat Abs" },
        %Leg {"ordinal": 28, "name": "WEEK 4: Rest Day" },
        
        %Leg {"ordinal": 29, "name": "WEEK 5: Plyo XT" },
        %Leg {"ordinal": 30, "name": "WEEK 5: Ripped Conditioning + Ultimate Abs" },
        %Leg {"ordinal": 31, "name": "WEEK 5: Muay Thai" },
        %Leg {"ordinal": 32, "name": "WEEK 5: Yoga XT" },
        %Leg {"ordinal": 33, "name": "WEEK 5: Legs & Back" },
        %Leg {"ordinal": 34, "name": "WEEK 5: Cardio XT + Ultimate Abs" },
        %Leg {"ordinal": 35, "name": "WEEK 5: Rest Day" }
        
    ]
})

DatabaseSeeder.completed_leg(1, 1) |> Repo.insert!
DatabaseSeeder.completed_leg(1, 2) |> Repo.insert!
DatabaseSeeder.completed_leg(1, 3) |> Repo.insert!
DatabaseSeeder.completed_leg(1, 4) |> Repo.insert!
DatabaseSeeder.completed_leg(1, 5) |> Repo.insert!
DatabaseSeeder.completed_leg(1, 6) |> Repo.insert!
DatabaseSeeder.completed_leg(1, 7) |> Repo.insert!

DatabaseSeeder.completed_leg(1, 8) |> Repo.insert!
DatabaseSeeder.completed_leg(1, 9) |> Repo.insert!
DatabaseSeeder.completed_leg(1,10) |> Repo.insert!
DatabaseSeeder.completed_leg(1,11) |> Repo.insert!
DatabaseSeeder.completed_leg(1,12) |> Repo.insert!
DatabaseSeeder.completed_leg(1,13) |> Repo.insert!
DatabaseSeeder.completed_leg(1,14) |> Repo.insert!

DatabaseSeeder.completed_leg(1,15) |> Repo.insert!
DatabaseSeeder.completed_leg(1,16) |> Repo.insert!
DatabaseSeeder.completed_leg(1,17) |> Repo.insert!
DatabaseSeeder.completed_leg(1,18) |> Repo.insert!
DatabaseSeeder.completed_leg(1,19) |> Repo.insert!
DatabaseSeeder.completed_leg(1,20) |> Repo.insert!
DatabaseSeeder.completed_leg(1,21) |> Repo.insert!

DatabaseSeeder.completed_leg(1,22) |> Repo.insert!
DatabaseSeeder.completed_leg(1,23) |> Repo.insert!
DatabaseSeeder.completed_leg(1,24) |> Repo.insert!
DatabaseSeeder.completed_leg(1,25) |> Repo.insert!
DatabaseSeeder.completed_leg(1,26) |> Repo.insert!
DatabaseSeeder.completed_leg(1,27) |> Repo.insert!
DatabaseSeeder.completed_leg(1,28) |> Repo.insert!

DatabaseSeeder.completed_leg(1,29) |> Repo.insert!
DatabaseSeeder.completed_leg(1,30) |> Repo.insert!
DatabaseSeeder.completed_leg(1,31) |> Repo.insert!
DatabaseSeeder.completed_leg(1,32) |> Repo.insert!


Repo.insert!(%Traveler{user: jonas, journey: tapout, name: jonas.name <> ": " <> tapout.name})


%TravelPlan{name: "Beginner to winner"} |> Repo.insert!

