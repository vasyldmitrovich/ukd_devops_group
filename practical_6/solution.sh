#!/bin/bash

echo "--- Task 1 ---"
grep -E "sudo[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.org" user_data.txt

echo -e "\n--- Task 2 ---"
grep -E "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.com, [a-zA-Z0-9]+$" user_data_task2.txt

echo -e "\n--- Task 3 (Report created in weak_password_report.txt) ---"
grep -E "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.com, [a-zA-Z0-9]+$" user_data_task2.txt | awk -F', ' '{printf "{\"%s\" : \"%s'\''s password is %s, it should be improved!\"}\n", $4, $2, $5}' > weak_password_report.txt

echo -e "\n--- Task 4 (JSON created in password_medium_report.json) ---"
grep -E "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.com" user_data_task2.txt | grep -E ", [A-Za-z0-9]{8,}$" | grep -P "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])" | awk -F', ' '{printf "{\"email\": \"%s\", \"user\": \"%s %s\", \"password_strength\": \"medium\", \"hint\": \"%s should include at least one special symbol!\"}\n", $4, $2, $3, $5}' > password_medium_report.json
