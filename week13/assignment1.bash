#! /bin/bash
clear

# filling courses.txt
bash courses.bash

courseFile="courses.txt"

function displayCoursesofInst(){

echo -n "Please Input an Instructor Full Name: "
read instName

echo ""
echo "Courses of $instName :"
cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
sed 's/;/ | /g'
echo ""

}

function courseCountofInsts(){

echo ""
echo "Course-Instructor Distribution"
cat "$courseFile" | cut -d';' -f7 | \
grep -v "/" | grep -v "\.\.\." | \
sort -n | uniq -c | sort -n -r 
echo ""

}

# TODO - 1
# Make a function that displays all the courses in given location
# function dislaplays course code, course name, course days, time, instructor
# Add function to the menu
# Example input: JOYC 310
# Example output: See the screenshots in canvas

function displayCoursesByLoc(){

echo ""
echo -ne "\033[97mPlease input a room name (EX: JOYC 310): \033[0m"
read roomName

echo ""
cat "$courseFile" | grep "$roomName" | cut -d';' -f1,2,5,6,7 | \
awk -F';' '{
    printf "\033[91m%s\033[0m | ", $1   
    printf "\033[32m%s\033[0m | ", $2  
    printf "\033[38;5;208m%s\033[0m | ", $3  
    printf "\033[94m%s\033[0m | ", $4  
    printf "\033[35m%s\033[0m\n", $5 
}'

echo ""

}

# TODO - 2
# Make a function that displays all the courses that has availability
# (seat number will be more than 0) for the given course code
# Add function to the menu
# Example input: SEC
# Example output: See the screenshots in canvas

function courseAvalible(){

	echo ""
	echo -ne "\033[97mPlease input a subject name (EX: SEC): \033[0m"
	read courseName


	echo ""
	awk -F';' '$4 > 0' "$courseFile" | grep "$courseName" | sed 's/;$//' | \
		awk -F';' '{
    		  printf "\033[91m%s\033[0m | ", $1; # class code 
    		  printf "\033[32m%s\033[0m | ", $2; # class name
    		  printf "\033[90m%s\033[0m | ", $3; # credits
    		  printf "\033[36m%s\033[0m | ", $4; # open seats
    		  printf "\033[38;5;208m%s\033[0m | ", $5; # day
    		  printf "\033[94m%s\033[0m | ", $6; # time
   		  printf "\033[35m%s\033[0m | ", $7; # Professor
		  printf "\033[31m%s\033[0m | ", $8; # from x date till x date
	  	  printf "\033[92m%s\033[0m | ", $9; # course requirement
  		  printf "\033[93m%s\033[0m\n", $10; # classroom location
		}'
	
}

while :
do
	echo -e "\033[1;97mPlease select an option:\033[0m"
	echo -e "\033[1;90m[\033[1;97m1\033[1;90m]\033[0m \033[1;94mDisplay courses of an instructor\033[0m"
	echo -e "\033[1;90m[\033[1;97m2\033[1;90m]\033[0m \033[1;94mDisplay course count of instructors\033[0m"
	echo -e "\033[1;90m[\033[1;97m3\033[1;90m]\033[0m \033[1;94mDisplay courses by classroom\033[0m"
	echo -e "\033[1;90m[\033[1;97m4\033[1;90m]\033[0m \033[1;94mDisplay available courses of a subject\033[0m"
	echo -e "\033[1;90m[\033[1;97m5\033[1;90m]\033[0m \033[1;94mExit\033[0m"
	
	read userInput
	echo ""

	if [[ "$userInput" == "5" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		displayCoursesofInst

	elif [[ "$userInput" == "2" ]]; then
		courseCountofInsts

	elif [[ "$userInput" == "3" ]]; then
		displayCoursesByLoc
	elif [[ "$userInput" == "4" ]]; then
		courseAvalible
	# TODO - 3 Display a message, if an invalid input is given
	else 
		echo ""
		echo -e "\033[1;91mNot an acceptible input try again\033[0m"
		echo ""
	fi
done
