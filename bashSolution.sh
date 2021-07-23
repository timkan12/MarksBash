#!/bin/bash

# ************************************************************UNCLASSIFIED************************************************************
#  Company: Northrop Grumman 
#  Date   : July 16, 2021
#  By     : Tim Kan M61636 for SWDC OPIR
#  Purpose: Cleaning up hpp files. Making it look neat without having to go and chang line by line
#  Instruction: ./test.sh <Inputfile> <outputfile> 
#               the user will need to specify input file and what they want it to output to.
#               user can choose to output at a .txt or a .cpp etc...
# ************************************************************UNCLASSIFIED************************************************************

i='/*----------------------------------------------------------------------*/
/*---------------------------- UNCLASSIFIED ----------------------------*/
/*----------------------------------------------------------------------*/

/*----------------------------------------------------------------------*/
/*----------------------------- DESCRIPTION ----------------------------*/
/*----------------------------------------------------------------------*/'
touch $2
echo -e "$i \n" > $2

j='/*----------------------------------------------------------------------*/
/*------------------------------ INCLUDES ------------------------------*/
/*----------------------------------------------------------------------*/'

echo -e "$j \n" >> $2
grep -i "#include" $1 >> $2

k='/*----------------------------------------------------------------------*/
/*------------------------ FORWARD DECLARATIONS ------------------------*/
/*----------------------------------------------------------------------*/'

echo -e "$k \n" >> $2

l='/*----------------------------------------------------------------------*/
/*------------------------------- USINGS -------------------------------*/
/*----------------------------------------------------------------------*/'

echo -e "$l \n" >> $2
x=$(grep -i "::" $1| gawk '{print $2}'|head -1| sed 's/::/ /g'| cut -d " " -f 1-4 )

for file in $x
do 
    echo "namespace $file {" >> $2
done


g='/*----------------------------------------------------------------------*/
/*-------------------------- GLOBAL VARIABLES --------------------------*/
/*----------------------------------------------------------------------*/'

echo -e "$g \n" >> $2

c='/*----------------------------------------------------------------------*/
/*----------------------- CONSTRUCTOR/DESTRUCTOR -----------------------*/
/*----------------------------------------------------------------------*/'

echo -e "$c \n" >> $2 
white='  '
x=$(grep -i "::" $1| gawk '{print $2}'|head -1| sed 's/::/ /g'| cut -d " " -f 5)
x=$(echo "$1" |cut -d ' ' -f 1| cut -d "." -f 1)
xx=$(grep -i "ImaginaryClass" $1| grep -i "*"| cut -d "(" -f 2  |sed 's/;/ :/g')
echo "$x::$x ($xx " >> $2
y=$(grep -i "::" $1| head -1| gawk '{print $5}' | sed 's~::~ ~g' | gawk '{print $5}')
echo "  $y()," >> $2
yy=$(grep -i "bool" $1 | grep -v "(" | grep -v "]" | sed 's~    ~//~g' | sed 's~ ~\n~g' | sed 's~;~~g')
echo "  $yy(false)" >> $2
gg=$(grep -i "char" $1 | head -1 |grep -v "(" | grep -v "]" | sed 's~    ~//~g' | sed 's~ ~\n~g' | sed 's~;~~g')
echo "  $gg('\0')" >> $2
unsig=$(grep -i "unsigned" $1| head -1| sed 's~    ~//~g'| sed 's~ ~\n~g'| sed 's~;~~g')
rest=$(grep -i "unsigned" $1| grep -v ']'| sed 's~    ~//~g'| cut -d " " -f 3| tail -n+2)
echo -e "unsinged \n  $unsig" >> $2
for x in $rest
do 
    echo "$x(0)" >> $2
done 
short=$(grep -i 'short' $1| head -1| sed 's~    ~//~g'| sed 's~ ~\n~g' )
echo "  $short(0)" >> $2
f='/*----------------------------------------------------------------------*/
/*------------------------------ FUNCTIONS -----------------------------*/
/*----------------------------------------------------------------------*/'

echo -e "$f \n" >> $2
x1=$(grep -i "bool" $1| grep -i "const" |grep -i "(" | sed -e 's/^[ \t]*//' | cut -d ' ' -f 1| sed 's~;~ \n{ \n\n}~g')   
y=$(grep -i "bool" $1| grep -i "const" |grep -i "(" | sed -e 's/^[ \t]*//' | cut -d ' ' -f 2-10| sed 's~;~ \n{ \n\n}~g')
echo "$x1 $x::$y" >> $2

ff='/*----------------------------------------------------------------------*/
/*----------------------------------------------------------------------*/'
echo -e "$ff" >> $2

x1=$(grep -i "double" $1| grep -i "const" |grep -i "(" | sed -e 's/^[ \t]*//' | head -1|cut -d ' ' -f 1)
x2=$(grep -i "double" $1| grep -i "const" |grep -i "(" | sed -e 's/^[ \t]*//' | head -1|cut -d ' ' -f 2-10| sed 's~;~ \n{ \n\n}~g')
echo "$x1 $x::$x2" >> $2

echo -e "$ff" >> $2

x1=$(grep -i "double" $1| grep -i "const" |grep -i "(" | sed -e 's/^[ \t]*//' | cut -d ' ' -f 1)
x2=$(grep -i "double" $1| grep -i "const" |grep -i "(" | sed -e 's/^[ \t]*//' | cut -d ' ' -f 2-10| sed 's~;~ \n{ \n\n}~g')

#for name in $1
#do
#echo "$x1 $x::$x2" >> $2
#done

#for name in $x1     ### Outer for loop ###
#do

    #for stuff in $x2 ### Inner for loop ###
    #do
 #   echo "$name $x::$x2" >> $2
    #done

#done



o='/*----------------------------------------------------------------------*/
/*------------------------------ OPERATORS -----------------------------*/
/*----------------------------------------------------------------------*/'

echo -e "$o \n" >> $2

t='/*----------------------------------------------------------------------*/
/*------------------------------ TEMPLATES -----------------------------*/
/*----------------------------------------------------------------------*/'

echo -e "$t \n" >> $2

c='/*----------------------------------------------------------------------*/
/*------------------------- CLOSING NAMESPACES -------------------------*/
/*----------------------------------------------------------------------*/'

echo -e "$c \n" >> $2



ii='/*----------------------------------------------------------------------*/
/*---------------------------- UNCLASSIFIED ----------------------------*/
/*----------------------------------------------------------------------*/'
echo -e "$ii \n" >> $2
