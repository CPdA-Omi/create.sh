#!/bin/bash

# Author : CPdA-Omi
# Creation Date : december 6 2021
# Last update : 05/17/2024 (MM/DD/YYYY)

author="CPdA-Omi"
genMsg="File created by create.sh ($author)"
helpMsg="(./$(basename $0) -H)"

alreadyExistingFile() {
	echo "The file \"$1\" already exists in this directory" >&2
	exit 1
}

multipleFileFormats() {
	echo "Error, multiple file formats entered $helpMsg" >&2
	exit 1
}

ifCreationError() {
	if [ $? -ne 0 ]; then
		echo "Unknown creation error"
		exit 1
	fi
}

fichiersC() {
	if [ "$mkf" = "1" ]; then
		if [ "$tree" = "1" ]; then
			echo '#'"$genMsg"'

CC=gcc

CFLAGS= -Wall -g

SRC=$(wildcard src/*.c)

OBJ=$(patsubst src/%.c,obj/%.o,$(SRC))

bin/exe: $(OBJ)
	$(CC) $(OBJ) -o $@

obj/%.o: src/%.c 
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm obj/*.o bin/exe' > $way\/makefile
		
		else
			echo "#$genMsg

exe:	$fic.o test$fic.o
		gcc $fic.o test$fic.o -o exe

$fic.o:	$fic.h $fic.c
		gcc -c $fic.c

test$fic.o:	$fic.h test$fic.c
			gcc -c test$fic.c

clean:
		rm -Rf *.o exe" > $way\/makefile
		fi

		ifCreationError
		echo "Creation of the makefile"
	fi

#===============================.makefile ^========-t v==============

	if [ "$tree" = "1" ]; then
		$(mkdir -p $way\/{src,obj,bin})

		ifCreationError
		way="$way/src"

		if [ "$file" == "1" ]; then
			echo "Creation of the tree $(pwd)/$fic/"
		else
			echo "Creation of the tree $(pwd)/"
		fi
	fi

#======================================-t ^========.h v==============

	echo "// $genMsg
#ifndef $(echo "$fic.h" | tr a-z A-Z | tr . ' ' | tr ' ' _)
#define $(echo "$fic.h" | tr a-z A-Z | tr . ' ' | tr ' ' _)

	int fct1 (void);

#endif //$(echo "$fic.h" | tr a-z A-Z | tr . ' ' | tr ' ' _)" > $way\/$fic.h
	if [ $? -ne 0 ]; then
		exit 1
	fi

#======================================.h ^========.c v==============
	echo "// $genMsg
// #include <stdio.h> // Only for the terminal communication
// #include <stdlib.h> // Only for uses of the following functions: exit, malloc, free, system or rand
#include \"$fic.h\"

int fct1 (void){
	return 6;
}" > $way\/$fic.c
	if [ $? -ne 0 ]; then
		exit 1
	fi

#======================================.c ^========test.c v==========

	echo "// $genMsg
#include <stdio.h> // Only for the terminal communication
#include \"$fic.h\"

void testFct1(void){
	int var;
	var=fct1();
	printf(\"Returned number: %d\n\", var);
}

int main (void){
	testFct1();
	return 0;
}" > $way\/test$fic.c
	if [ $? -ne 0 ]; then
		exit 1
	fi

	echo "Creation of the files \"$fic.h\", \"$fic.c\" et \"test$fic.c\""

#==================================test.c ^========chmod v===========

	chmod $chmod $way\/*

	if [ "$tree" == "1" ]; then
		chmod $chmod "$way/../makefile"
	fi

	if [ -x $way\/$fic.c ]; then
		chmod a-x $way\/$fic.h $way\/$fic.c $way\/test$fic.c
	else
		chmod a+x "$way/../makefile"
	fi

#===================================chmod ^========-o v==============

	if [ "$open" = "1" ]; then
		if [ -z $openCmd ]; then
			subl $way\/$fic.h $way\/$fic.c $way\/test$fic.c
			echo "Opening files \"$fic.h\", \"$fic.c\" et \"test$fic.c\" on Sublime Text"
		else
			$openCmd $way\/$fic.h $way\/$fic.c $way\/test$fic.c
			echo "Opening files \"$fic.h\", \"$fic.c\" et \"test$fic.c\""
		fi
	fi
	exit 0
} #=========================================================================fichiersC



creation() {
	if [ "$file" = "1" ]; then
		mkdir $fic
		if [ $? -eq 0 ]; then
			echo "Directory \"$fic\" created"
		else
			exit 1
		fi
		way="$fic"
	fi

#======================================-d ^========-c v==============

	if [ "$c" = "1" ]; then
		fichiersC

#======================================-c ^========-sh v=============

	elif [ "$sh" = "1" ]; then
		fic="$fic.sh"
		echo "#!/bin/bash
#$genMsg

echo 'Hello, World!'" > $way\/$fic
		ifCreationError

#=====================================-sh ^========-py v=============

	elif [ "$py" = "1" ]; then
		fic="$fic.py"
		echo "#$genMsg

if __name__ == '__main__':

	print(\"Hello, World!\")" > $way\/$fic
		ifCreationError

#=====================================-py ^========-html v===========

	elif [ "$html" = "1" ]; then
		fic="$fic.html"
		echo "<!-- $genMsg -->
<!DOCTYPE html>
<html lang=\"en\">
	<head>
		<meta charset=\"utf-8\">
		<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
		<title>$(echo $fic | cut -d '.' -f 1)</title>
	</head>
	<body>
		<header>
			<h1>Hello, World!</h1>
		</header>
		<main>
		</main>
		<footer>
		</footer>
	</body>
</html>" > $way\/$fic
		ifCreationError

#====================================-html ^=========================

	else
		echo -e "// $genMsg\n// No valid file extension entered.\n" > $way\/$fic
		ifCreationError
	fi
	chmod $chmod $way\/$fic
	echo "Creation of the file \"$fic\""

#==================================================-o v==============

	if [ "$open" = "1" ]; then
		if [ -z $openCmd ]; then
			subl $way\/$fic
			echo "Opening of the file \"$fic\" on Sublime Text"
		else
			$openCmd $way\/$fic
			echo "Opening of the file \"$fic\""
		fi
	fi
}

guide() {
	local borderCharacter="\e[33;1m|\e[0m"
	echo -e "
  \e[1m#\e[33m======================================================\e[0;1m GUIDE $(basename $0 | tr a-z A-Z) \e[33m======================================================\e[0;1m#\e[0m
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}	  The file \"$(basename $0)\" is a script which fastly create with a lot of options described right down			${borderCharacter}
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}	  \e[33;4mWorking :\e[0m														${borderCharacter}
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}	  All is working with arguments in order to have the fastest execusion but the first can have multiple utilities :	${borderCharacter}
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}	  Rights can be entered directly as the \e[4mfirst argument\e[0m (ex: 642). This field is \e[1moptional\e[0m.				${borderCharacter}
  ${borderCharacter}	  If rights are not entered, the rights \"755\" will be the default ones.							${borderCharacter}
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}	  Then, the following value will be the file name that will be created. \e[1mThis argument is \e[4mnecessary\e[0;1m for the good 	${borderCharacter}
  ${borderCharacter}	  behaviour of the script.												${borderCharacter}
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}	  All the following arguments can be used in any order (except \"-M\" and \"-T\") and those are their functions.		${borderCharacter}
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}	  \e[33;4mOptions :\e[0m														${borderCharacter}
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}	  By default, a file does not have a format but three are set in this script :						${borderCharacter}
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}		  \e[94m-HT (--html)\e[0m    : create the file in the html format (with all the main tags) ;				${borderCharacter}
  ${borderCharacter}		  \e[93m-PY (--python)\e[0m  : create the file in the python format (with a python main) ;					${borderCharacter}
  ${borderCharacter}		  \e[96m-SH (--shell)\e[0m   : create the file in the bash format (with the shebang) ;					${borderCharacter}
  ${borderCharacter}		  \e[31m-C (--clang)\e[0m    : create all the files necessary to run a c program :						${borderCharacter}
  ${borderCharacter}				       a .c file, a .h file and a test.c file with all necessary				${borderCharacter}
  ${borderCharacter}				       imports for a good use already set in the files.						${borderCharacter}
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}	  \e[31m-M (--makefile)\e[0m : sub-option of \"-C\" creating a makefile file for to compile using \e[3mmake\e[0m				${borderCharacter}
  ${borderCharacter}			    This sub-option \e[1mcan only be entered after \"-C\" or \"-T\"\e[0m.						${borderCharacter}
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}	  \e[31m-T (--tree)\e[0m  : sub-option of \"-C\" creating an entire tree structure within the files :				${borderCharacter}
  ${borderCharacter}			  - bin,												${borderCharacter}
  ${borderCharacter}			  - obj (for the .o files created using \e[3mmake\e[0m),								${borderCharacter}
  ${borderCharacter}			  - src (where the C files will be stored).								${borderCharacter}
  ${borderCharacter}			 This sub-option \e[1mcan only be entered after \"-C\" or \"-M\"\e[0m.						${borderCharacter}
  ${borderCharacter}			 \e[4mI highly recommand you to use this sub-option with the \"-D\" option.\e[0m					${borderCharacter}
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}	  \e[32m-D (--directory)\e[0m : option creating a directory where the files will be created.					${borderCharacter}
  ${borderCharacter}	  		     If this option is not entered, all the files will be created in the actual directory (pwd).	${borderCharacter}
  ${borderCharacter}			       Example : \e[3m./$(basename $0) bubble -C\e[0m will create \"bubble.h\", \"bubble.c\" and \"testbubble.c\"		${borderCharacter}
  ${borderCharacter}			       in the \e[3mbubble\e[0m directory.										${borderCharacter}
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}	  \e[32m-O (--open)\e[0m : option that opens all the created files (except the makefile if created).				${borderCharacter}
  ${borderCharacter}		 	By default, those files are opened via \e[3mSublime Text\e[0m but you can change that by enter a command		${borderCharacter}
  ${borderCharacter}		 	that opens a text editor right after this option (or change the lines 146 and 232 of the script).	${borderCharacter}
  ${borderCharacter}			  Example : \e[3m./$(basename $0) rabbit -SH -O vi\e[0m will open the \"rabbit.sh\" using \e[3mvi\e[0m.				${borderCharacter}
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}	  \e[32m-H (--help)\e[0m : option that opens that guide if used as first argument.							${borderCharacter}
  ${borderCharacter}		 	In memory of the first script versions, the \"-guide\" option still works.				${borderCharacter}
  ${borderCharacter}			If this guide is open, no other action will be effective.						${borderCharacter}
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}	  Another option that create C++ and JS files (and React coponents) might comes later...				${borderCharacter}
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}	  \e[33;4mExemples :\e[0m														${borderCharacter}
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}	  ./$(basename $0) chat -D --html												${borderCharacter}
  ${borderCharacter}	  ./$(basename $0) toto -C -M --directory											${borderCharacter}
  ${borderCharacter}	  ./$(basename $0) 744 titi --open -PY											${borderCharacter}
  ${borderCharacter}	  ./$(basename $0) lapin -O gedit -D -SH											${borderCharacter}
  ${borderCharacter}	  ./$(basename $0) 700 nounours -D --clang --tree --makefile									${borderCharacter}
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}																${borderCharacter}
  ${borderCharacter}						  create.sh V1.6.2 (2021->2024)  						${borderCharacter}
  ${borderCharacter}							Created by CPdA-Omi							${borderCharacter}
  \e[0;1m#\e[33m=============================================================================================================================\e[0;1m#\e[0m" | less
}

#================================================================================Main==================================================================================#

if [ $# -eq 0 ]; then
	echo "Error, enter a file name $helpMsg." >&2
	exit 1
fi

if echo $1 | egrep -q "[0-7]{3}" ; then
	chmod=$1; shift
elif [ $1 = -guide -o $1 = -H -o $1 = --help ]; then
	guide
	exit 0
else
	chmod="755"
fi

languageCpt=0; way="."; fic=$1; shift


while [ $# -ne 0 ]; do
	case $1 in
		"-HT"|"-html")
			if [ -e "$fic.html" ]; then
				alreadyExistingFile "$fic.html"
			else
				if [ $languageCpt -eq 0 ]; then
					html=1
					languageCpt=1
					shift
				else
					multipleFileFormats
				fi
			fi
			;;

		"-PY"|"--python")
			if [ -e "$fic.py" ]; then
				alreadyExistingFile "$fic.py"
			else
				if [ $languageCpt -eq 0 ]; then
					py=1
					languageCpt=1
					shift
				else
					multipleFileFormats
				fi
			fi
			;;
		
		"-SH"|"--shell")
			if [ -e "$fic.sh" ]; then
				alreadyExistingFile "$fic.sh"
			else
				if [ $languageCpt -eq 0 ]; then
					sh=1
					languageCpt=1
					shift
				else
					multipleFileFormats
				fi
			fi
			;;

		"-C"|"--clang")
			if [ -e "$fic.c" ] ; then
				alreadyExistingFile "$fic.c"
			else
				if [ $languageCpt -eq 0 ]; then
					c=1
					languageCpt=1
					shift
					for i in $1 $2; do
						if [ $i = -T -o $i = --tree ]; then
							tree=1
							shift
						elif [ $i = -M -o $i = --makefile ]; then
							mkf=1
							shift
						fi
					done
				else
					multipleFileFormats
				fi
			fi
			;;

		"-O"|"--open")
			open=1
			shift
			if [ ! -z $1 ]; then 
				if [ $1 != -* ]; then
					openCmd=$1
					shift
				fi
			fi
			;;

		"-D"|"--directory")
			file=1; shift
			;;

		*)
			echo "Error: enter a valid option $helpMsg" >&2
			exit 1
			;;
	esac
done

if [ -e $fic -a $languageCpt -eq 0 ]; then
	echo "The file or the directory \"$fic\" already exists in this directory"
else
	creation
fi
