#!/bin/bash

#checking if 'espeak' is already installed or not

if ! command -v espeak &> /dev/null
then
    echo "Please install the program 'espeak' to get an audio notification when the time is up..."
    exit
fi

#taking the input from the user -->

echo "This is a countdown timer. Please provide the following inputs : Hours, Minutes and Seconds."
echo ""
echo "Please set the Hours for the timer --> "
read hr
echo "Please set the Minutes for the timer --> "
read mn
echo "Please set the Seconds for the timer --> "
read sc

#a dirty way to loop back to input validation -->
#checking if the inputs are just numbers. If not then retake the input. Can be done individually for each input as well.-->
FuncChk()
{
if [[ -n ${hr//[0-9]/} ]] || [[ -n ${mn//[0-9]/} ]] || [[ -n ${sc//[0-9]/} ]] 
then
FuncInp
fi
}


#a dirty way to loop back to taking inputs -->

FuncInp()
{
echo ""
tput setaf 1; echo "Only numbers are allowed"
tput sgr0
echo ""
echo "Please set the Hours for the timer --> "
read hr
echo "Please set the Minutes for the timer --> "
read mn
echo "Please set the Seconds for the timer --> "
read sc
FuncChk
}

#input validation -->

if [[ -n ${hr//[0-9]/} ]] || [[ -n ${mn//[0-9]/} ]] || [[ -n ${sc//[0-9]/} ]] 
then
FuncInp
fi

#actual program logic starts -->

echo ""
echo "Timer is set for: --> "
$time
#converting the hours, minutes and seconds into seconds
timer=$((($hr*3600)+($sc)+($mn * 60)))
echo "$hr Hours : $mn Minutes : $sc Seconds"
echo "-------------------Timer Started------------------------"
#reducing the value of seconds at each second
while [ $timer -ge 0 ] 
do
	sleep 1 &
	hr=$(($timer/3600))
	mn=$((($timer-($hr*3600))/60))
	sc=$((($timer)-($hr*3600)-($mn*60)))
	echo -ne "$hr Hours : $mn Minutes : $sc Seconds "\\r
	((timer-=1))
	wait

done
espeak 'Time is up.'
echo ""
echo "-------------------Timer Stopped------------------------"
echo "Time is up. Countdown stopped."
