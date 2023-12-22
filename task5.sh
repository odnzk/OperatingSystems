#!/bin/bash

guessed_numbers=()
total_attempts=0
guessed_attempts=0

while true; do
    random_number=$((RANDOM % 10))
    ((total_attempts++))

    echo "Turn $total_attempts: Enter a number from 0 to 9 (or 'q' to quit):"
    read user_input

    if [[ $user_input == "q" ]]; then
        echo "Quitting the game."
        break
    fi

    if ! [[ $user_input =~ ^[0-9]$ ]]; then
        echo "Error: Please enter a single digit number from 0 to 9 or 'q' to quit."
        continue
    fi

    guessed=false
    if [[ $user_input -eq $random_number ]]; then
        guessed=true
        ((guessed_attempts++))
    fi

    guessed_numbers+=($user_input)
    if [[ ${#guessed_numbers[@]} -gt 10 ]]; then
        guessed_numbers=("${guessed_numbers[@]:1}")
    fi

    echo "Guessed: $guessed_attempts/$total_attempts ($(bc <<< "scale=2; $guessed_attempts*100/$total_attempts")%)"
    echo "Not Guessed: $((total_attempts - guessed_attempts))/$total_attempts ($(bc <<< "scale=2; ($total_attempts-$guessed_attempts)*100/$total_attempts")%)"
    echo "Last 10 guessed numbers: "
    for number in ${guessed_numbers[@]}; do
        if [[ $number -eq $user_input ]]; then
            echo -e "\e[32m$number\e[0m\c "
        else
            echo -e "\e[31m$number\e[0m\c "
        fi
    done
    echo ""
done
