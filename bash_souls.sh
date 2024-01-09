#!/bin/bash

# Bash Soul! Choose your name and your class!
echo "Welcome to Bash Souls! Are you ready to face incredible monsters?
Hero, tell us more about urself. What's your name?"
read player_name
echo "Choose your class:
1) Archer
2) Assassin
3) Warrior
4) Priest
5) Sorcerer"

# Function to print a monster when they appear
print_monster() {
	echo -e "
                           .-.
                          (o o)
                          /  V  \\
                         /   _   \\
                        /          \\
                       /    \\_/    \\
                      /   |    |    \\
                     /   |  | |  |   \\
                     \\__/  | |  | __/
                         \\ | |  |/
                          \\| | /
                           | |/
                           / \\
                          /   \\
"
}

# Defining stats variable for the player
hp=0
strength=0
agility=0
luck=0

# Choosing the class and assigning respective stats value with input validation
read class
case $class in
    1)
        player_class=Archer
        hp=60
        strength=4
        agility=6
        luck=4
        ;;
    2)
        player_class=Assassin
        hp=50
        strength=3
        agility=7
        luck=3
        ;;
    3)
        player_class=Warrior
        hp=80
        strength=7
        agility=4
        luck=4
        ;;
    4)
        player_class=Priest
        hp=65
        strength=3
        agility=5
        luck=5
        ;;
    5)
        player_class=Sorcerer
        hp=50
        strength=3
        agility=4
        luck=6
        ;;
    *)
        echo "Invalid option. Exiting."
        exit 1
        ;;
esac

# Let's Battle: Generating two numbers; if they match, you win the battle and increase your stats!
# If they don't match, you lose health and you can try again.
# After each battle, the beast stats will increase!

beast_killed=0
beast_hp=10
beast_atk=2
beast_agility=1

# Starting the game
while (( hp > 0 )); do

    # Beast Fight
    echo "A beast appeared! Get Ready to Fight!"
    print_monster
    while (( beast_hp > 0 )); do
        echo "Pick a number between 0 and 1!"
        read -r player

        # Input validation for the beast fight
        if [[ $player =~ ^[01]$ ]]; then
            beast=$((RANDOM % 2))
            if (( player == beast || strength > 20 && agility > 20 )); then
                (( beast_atk++, beast_hp--, beast_agility++, hp -= beast_atk, strength += 2, agility += 2, beast_killed++ ))
                # Increasing stats and ensuring hp is not 0. If hp > 0 use hp, else use 0
                echo "You won!
                Your HP is now $((hp > 0 ? hp : 0))
                Your Attack is now $strength
                Your Agility is now $agility"
                break
            elif (( player != beast )); then
                (( hp -= beast_atk ))
                echo "You took some damage! Your health is now $((hp > 0 ? hp : 0))"
            else
                echo "You Died!"
                echo "$player_name, you have killed $beast_killed monsters!"
                exit 1
            fi
        else
            echo "Invalid input. Please enter 0 or 1."
        fi
    done

    # Boss Fight
    boss=$((RANDOM % 10))
    secret_code="Muoriii!"
    echo "A boss appeared! Pick a number between 0 and 9 or enter the secret to instantly defeat the boss"
    read -r player
    if [[ $player =~ ^[0-9]$ && $player -eq $boss || $player == "$secret_code" ]]; then
        (( strength += 5, agility += 5, luck += 3 ))
        echo "You defeated the Boss! Well done
            Your HP is now $((hp > 0 ? hp : 0))
            Your Attack is now $strength
            Your Agility is now $agility"
    elif (( luck > 99 )); then
        echo "Today is your lucky day!"
    else
        echo "You Died!"
        echo "$player_name, you have killed $beast_killed monsters!"
        exit 1
    fi
done

# Checking if the player has died; if so, quit the program and tell how many monsters did you killed!
if (( hp <= 0 )); then
    echo "You Died!"
    echo "$player_name, you have killed $beast_killed monsters!"
fi
