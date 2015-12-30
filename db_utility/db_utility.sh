#!/bin/bash
#DB Utilities Console
# a hub for SWG DB utilities
#Created by RisTanA 12/29/2015
#version 0.1
#last edit 12/29/2015


#set variables
$selection = 0
$selectionLogic = 0
$pw = 0
$pwcheck = 420
$confirm = 0

##functions start here

#main_console function
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
}

#cant_paint function
cant_paint()
{
echo ' '
echo 'Authorized users only'
echo 'Enter password:'
read pw
if [[ $pw == $pwcheck]]

then
echo ' '
echo 'Access Granted'
echo ' '

else
echo 'Permission Denied'
stop_program

fi
}

#dba_credentials function
dba_credentials()
{
echo 'Please enter your database credentials that have SYSDBA permissions:'
echo ' '
echo 'Enter your username:'
read $username
echo ' '
echo 'Enter your password:'
read $password
echo ' '
echo ' '
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
echo 'Details about the program will be provided'
echo ' '
echo '**********************************'
echo ' '
echo ' '
$selectionLogic = 1 #enable selection logic
}

#run_program function
run_program()
{
echo ' '
echo 'Running selected program'
echo ' '
selection_$selection
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
echo 'Would you like to return to perform another action?'
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

}

#confirm_selection
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

#selection_1 function
selection_1()
{ 
echo 'Lock Characters will disable characters by editing the'
echo 'enabled column in the swg_characters table'


		
	sqlplus
	sqlplus -s $username/$password << EOF
set echo off 
set heading off

@sql/lock_characters.sql
exit;
EOF
fi
}

#selection_2 function
selection_2()
{ 
echo 'Unlock Characters will enable characters by'
echo 'editing the enabled column in the swg_characters table'
		
	sqlplus
	sqlplus -s $username/$password << EOF
set echo off 
set heading off

@sql/unlock_characters.sql
exit;
EOF
fi
}

#test_function
selection_999()
{
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
