#! /bin/bash
#echo "1st arg =$1"
if [[ $# == '0' ]]
then 
echo "-i:  Insert new contact name and number "
echo "-v:  View all saved contacts details"
echo "-s:  Search by contact name"
echo "-e:  Delete all record"
echo "-d:  Delete only one contact name"
fi

if [[ $1 == "-i" ]];
then
       read -p "enter name:  " name
       found=$(grep -E "(^>>>$name;)" phonebook)
       echo $found
       nameloc=$(grep -E "(^>>>$name;)" phonebook |sed -E "/${name}/!d " | cut -d ";" -f 1)
       if [[ $nameloc == ">>>$name" ]]
        then
              read -p "do you want to  add another phone  number to same contact ? YES or NO " YESorNO
              if  [[ $YESorNO == "YES" ]]
	       then
                    read -p "enter another phone number: " number
		    if [[ $number =~  ^[0-9]+$ ]]
          	    then
                 	echo "Correct number"
                 	echo "Contact name is already registered,another phone number is added to same contact ."
                        sed -i "/^>>>${name};/d" phonebook 
                        echo "$found;$number">> phonebook
           	    else
                 	echo "Wrong number, please try again"
           	     fi
               else
		 echo "Okay no new phone number is added to same name contact"
               fi
        else
           read -p "enter phone number: " number
           if [[ $number =~  ^[0-9]+$ ]]
           then
                 echo "Correct number"
                 echo ">>>$name;$number" | tee -a phonebook
           else
                 echo "Wrong number, please try again"
           fi
           #echo ">>>$name;$number" | tee -a phonebook
        fi
fi

if [[ $1 == "-v" ]]
then    
        echo " "
        echo "view phonebook database:"
        echo " "
	cat phonebook |grep "^>>>" 

fi


if [[ $1 == "-s" ]] 
then
       read -p "enter name you want to search :" searchname
	#nameloc=$(grep -E "($searchname;)" phonebookDB.txt |sed -E "/${searchname}/!d " | cut -d ";" -f 1)
        nameloc=$(grep -E "(^>>>$searchname;)" phonebook | cut -d ";" -f 1)

       # echo "nameloc     = $nameloc"
       # echo "search name = $searchname"
        if [[ $nameloc == ">>>$searchname" ]]
        then 
		echo " "
		echo "Contact name is found :))"
		final= grep -E "(^>>>$searchname;)" phonebook 
		echo " "
		echo $final
        else
         	echo " "
		echo "Contact name is notfound"
        fi
fi

if [[ $1 ==  "-d" ]]
then
        read -p "enter contact name you want to delete :" deletename

        nameloc=$(grep -E "(^>>>$deletename;)" phonebook |sed -E "/${deletename}/!d " | cut -d ";" -f 1)
        #echo "nameloc     = $nameloc"
        #echo "search name = $deletename"
        echo " "
        if [[ $nameloc == ">>>$deletename" ]]
        then 
               sed -i "/^>>>${deletename};/d" phonebook 
		echo "Contact name is deleted "
        else
                echo "Contact name is notfound to delete"
        fi

fi

if  [[ $1 ==  "-e" ]]
then  
         sed -i "/^>>>/d" phonebook 
         echo "DataBase is deleted :(( "  
fi

exit 0
#########################################################################################################################################
#PHONEBOOK Database#
>>>ali ahmed;011145678
>>>ali;015442876
>>>roanne khaled;0127654391
>>>khaled khaled;0127765433 
>>>ahmed ali;012345677;012345678

