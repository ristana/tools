#!/bin/bash
#DB Utilities Console
# a hub for SWG DB utilities
#Created by RisTanA 12/29/2015
#version 0.1
#last edit 12/29/2015

#set variables
selection=0
pw=0
pwcheck=420
confirm=0
falseInput=0
cread_check_yn=0
inputVariable=0

##functions start here

#main_console function
#
main_console()
{
echo '##################################'
echo '#                                #'
echo '#     DB Utilities Console       #'
echo '#                           v0.1 #'
echo '##################################'
echo ' '
echo ' '
echo ' '
echo ' '
echo '----------------------------------'
echo ' '
echo ' '
}

#awaiting_input
awaiting_input()
{
echo 'Awaiting input...'
read falseInput
}

#cant_paint function
cant_paint()
{
echo ' '
echo 'Authorized users only'
echo 'Enter password:'
read pw
if [ $pw = $pwcheck ]
then
echo ' '
echo 'Access Granted'
echo ' '

else
echo 'Permission Denied'
stop_program

fi
awaiting_input
}

#dba_credentials function
dba_credentials()
{
echo ' '
echo 'WARNING: Authorized users only:'
echo ' '
echo ' '
echo 'Please enter your database credentials'
echo ' '
echo 'Enter your username:'
read username
echo ' '
echo 'Enter your password:'
read password
echo ' '
echo ' '
credentials_check
}

#credentials_check function
credentials_check()
{
echo ' '
echo 'Checking credentials...'
echo ' '
awaiting_input

sqlplus -s $username/$password << EOF

exit;
EOF

echo ' '
echo ' '
echo ' '
echo 'Would you like to retry? [y/n]'
echo ' '
read cread_check_yn

if [[ $cread_check_yn == "y" ]]
then
echo ' '
echo ' '
dba_credentials

elif [[ $cread_check_yn == "Y" ]]
then
echo ' '
echo ' '
dba_credentials
elif [[ $cread_check_yn = "n" ]]
then
echo ' '
echo ' '

elif [[ $cread_check_yn = "n" ]]
then
echo ' '
echo ' '

else
echo ' '
echo 'invalid response, please enter y or n'
echo ' '
credentials_check
fi
}

#selection_list function
selection_list()
{
echo 'List of available programs'
echo ' '
echo '**********************************'
echo ' '
echo '1: Lock Characters'
echo '2: Unlock Characters'
echo '999: test'
echo ' '
echo '**********************************'
echo ' '
echo ' '
}

#choose_program function
choose_program()
{
echo 'Enter the number that corresponds to the program you wish to run: '
echo ' '
read selection
echo 'You chose ' $selection
echo ' '
echo '**********************************'
echo ' '

}

#function stop_program
stop_program()
{
echo ' '
echo ' '
echo 'Program Exiting'
echo ' '
exit
}

#run_again function
run_again()
{
echo 'Would you like to perform another action?'
echo 'y/n:'
read yn
if [[ $yn == "y" ]]
then
echo ' '
echo ' '
selection_list

elif [[ $yn == "Y" ]]
then
echo ' '
echo ' '
selection_list

elif [[ $yn = "n" ]]
then
echo ' '
echo ' '
stop_program

elif [[ $yn = "n" ]]
then
echo ' '
echo ' '
stop_program

else
echo ' '
echo 'invalid response, please enter y or n'
echo ' '
run_again
fi

choose_program
run_program
run_again
stop_program

}



#confirm_selection function
confirm_selection()
{
echo ' '
echo 'Do you wish to run this program?'
echo 'y/n'
read confirm

if [[ $confirm == "y" ]]
then
echo ' '
echo ' '
echo 'running program ' $selection

elif [[ $confirm == "Y" ]]
then
echo ' '
echo ' '
echo 'running program ' $selection

elif [[ $confirm = "n" ]]
then
echo ' '
echo ' '
run_again

elif [[ $confirm = "n" ]]
then
echo ' '
echo ' '
run_again

else
echo ' '
echo 'invalid response, please enter y or n'
echo ' '
confirm_selection
fi
}

#run_program function
run_program()
{
echo ' '
echo 'Starting selected program...'
echo ' '
echo 'Details will be provided'
echo ' '
echo '------------------------------'
echo ' '
echo 'Description: '
echo ' '
selection_$selection
}

#selection_1 function
selection_1()
{ 
echo 'Lock Characters will disable characters by editing the'
echo 'enabled column in the swg_characters table'

confirm_selection

echo ' '
echo ' '
echo 'Which character would you like to lock:'
read inputVariable
echo 'you have selected to lock:' $inputVariable
echo ' '
echo 'This is your last chance to abort'
awaiting_input
echo 'Locking '$inputVariable

	sqlplus -s $username/$password << EOF
set echo off 
set heading off

@sql/lock_characters.sql
$inputVariable
exit;
EOF

}

#selection_2 function
selection_2()
{ 
echo 'Unlock Characters will enable characters by'
echo 'editing the enabled column in the swg_characters table'

confirm_selection

echo ' '
echo ' '
echo 'Which character would you like to unlock:'
read inputVariable
echo 'you have selected to Unlock:' $inputVariable
echo ' '
echo 'This is your last chance to abort'
awaiting_input
echo 'Unlocking '$inputVariable


	sqlplus $username/$password <<EOF
set echo off
set heading off

@sql/unlock_characters.sql
$inputVariable
exit;
EOF

}

#test_function
selection_999()
{
echo 'Test description'

confirm_selection

echo ' '
echo 'This is a test'
echo ' '
}

##functions stop here


##Logic starts here

cant_paint
main_console
dba_credentials
selection_list
choose_program
run_program
run_again
stop_program

##Logic ends here
