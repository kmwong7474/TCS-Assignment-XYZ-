#!/bin/bash

# Disable file name generation
set -f

# List of characters to try
LIST1="A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
LIST2="0 1 2 3 4 5 6 7 8 9"
LIST3="a b c d e f g h i j k l m n o p q r s t u v w x y z"
LIST4="~ @ # $ % ^ * _ + - = { } [ ] ? ; :"
LIST5="~ @ # $ % ^ * _ + - = { } [ ] ? ; :"

# Prompt user to select hashes
echo "Select A01 to A07"
read choice

# Following script extracts the hash values, salt values and encrypted passwords from the file(AtoDhashes.txt) and display them.
# salt = salt values
# encr = encrypted passwords
echo $choice " hash values: "`grep $choice AtoDhashes.txt | cut -d":" -f2`
salt=`grep $choice AtoDhashes.txt | cut -d":" -f2 | cut -d"$" -f3`
echo "Salt values: " $salt
encr=`grep $choice AtoDhashes.txt | cut -d":" -f2 | cut -d"$" -f4`
echo "Encrypted passwords: " $encr

# Pause the script to let user verify the hashes and salt values
read -p "Press Enter to continue..."

# Script to generates all the possible combinations of a 5-digit password based on the lists to try.
for i in $LIST1
 do
   for j in $LIST2
    do
      for k in $LIST3
       do
         for l in $LIST4
          do
            for m in $LIST5
			 do
	       echo -n "$i$j$k$l$m "
	   
test=`mkpasswd -m md5 $i$j$k$l$m -s $salt | cut -d":" -f2 | cut -d"$" -f4`

		if [ $test == $encr ] ; then
			echo "Password is: $i$j$k$l$m"
			exit
		fi
             done
		  done
       done
    done
 done