#!/bin/bash

# Author : CPdA-Omi
# Creation Date : december 6 2021
# Last update : 07/23/2023

author="CPdA-Omi"
genMsg="Fichier généré grâce à create.sh ($author)"

fichiersC() {
	if [ "$mkf" = "1" ]; then
		if [ "$tree" = "1" ]; then
			echo '#Fichier makefile créé par Mme Carine Simon avec un "C"
#'"$genMsg"'

#CC : le compilateur à utiliser
CC=gcc

#CFLAGS : les options de compilation
CFLAGS= -Wall -g

# les fichiers sources : tous les fichiers présents dans src/
SRC=$(wildcard src/*.c)

# les fichiers objets (.o)
OBJ=$(patsubst src/%.c,obj/%.o,$(SRC))


#édition des liens : génération de l'\''exécutable à partir des .o 
bin/exe: $(OBJ)
	$(CC) $(OBJ) -o $@

# génération des .o à partir des .c et .h crrespondants : 
obj/%.o: src/%.c 
	$(CC) $(CFLAGS) -c $< -o $@

#nettoyage : destruction des .o et de l'\''exécutable
clean:
	rm obj/*.o bin/exe' > $way\/makefile
		
		else
			echo "#Fichier makefile créé par M. Hasbani
#$genMsg

exe:	$fic.o test$fic.o
		gcc $fic.o test$fic.o -o exe

$fic.o:	$fic.h $fic.c
		gcc -c $fic.c

test$fic.o:	$fic.h test$fic.c
			gcc -c test$fic.c

clean:
		rm -Rf *.o exe" > $way\/makefile
		fi

		if [ $? -ne 0 ]; then
			exit 1
		fi
		echo "Création du fichier makefile"
	fi

#===============================.makefile ^=========.tree v==========

	if [ "$tree" = "1" ]; then
		$(mkdir -p $way\/{src,obj,bin})

		if [ $? -ne 0 ]; then
			exit 1
		fi
		way="$way/src"

		if [ "$file" == "1" ]; then
			echo "Création des l'arborescence dans $(pwd)/$fic/"
		else
			echo "Création des l'arborescence dans $(pwd)/"
		fi
	fi

#===================================.tree ^=========.h v=============

	echo "// $genMsg
#ifndef $(echo "$fic.h" | tr a-z A-Z | tr . ' ' | tr ' ' _)
#define $(echo "$fic.h" | tr a-z A-Z | tr . ' ' | tr ' ' _)

	int fct1 (void);

#endif //$(echo "$fic.h" | tr a-z A-Z | tr . ' ' | tr ' ' _)" > $way\/$fic.h
	if [ $? -ne 0 ]; then
		exit 1
	fi

#======================================.h ^=========.c v=============
	echo "// $genMsg
// #include <stdio.h> // Seulement si communication avec le terminal
// #include <stdlib.h> // Seulement si utilisation des fonctions suivantes : exit, malloc, free, system ou rand
#include \"$fic.h\"

int fct1 (void){
	return 6;
}" > $way\/$fic.c
	if [ $? -ne 0 ]; then
		exit 1
	fi

#======================================.c ^=========test.c v=============
	echo "// $genMsg
#include <stdio.h> // Seulement si communication avec le terminal
#include \"$fic.h\"

void testFct1(void){
	int var;
	var=fct1();
	printf(\"Nombre de retour : %d\n\", var);
}

int main (void){
	testFct1();
	return 0;
}" > $way\/test$fic.c
	if [ $? -ne 0 ]; then
		exit 1
	fi

	echo "Création des fichiers\"$fic.h\", \"$fic.c\" et \"test$fic.c\""

#==================================================chmod v===============

	chmod $chmod $way\/*

	if [ "$tree" == "1" ]; then
		chmod $chmod "$way/../makefile"
	fi

	if [ -x $way\/$fic.c ]; then
		chmod a-x $way\/$fic.h $way\/$fic.c $way\/test$fic.c
	else
		chmod a+x "$way/../makefile"
	fi

	if [ "$open" = "1" ]; then
		if [ -z $openCmd ]; then
			subl $way\/$fic.h $way\/$fic.c $way\/test$fic.c
			echo "Ouverture des fichiers \"$fic.h\", \"$fic.c\" et \"test$fic.c\" sous Sublime Text"
		else
			$openCmd $way\/$fic.h $way\/$fic.c $way\/test$fic.c
			echo "Ouverture des fichiers \"$fic.h\", \"$fic.c\" et \"test$fic.c\""
		fi
	fi
	exit 0
} #=========================================================================fichiersC

creation() {
	if [ "$file" = "1" ]; then
		mkdir $fic
		if [ $? -eq 0 ]; then
			echo "Répertoire \"$fic\" créé"
		else
			exit 1
		fi
		way="$fic"
	fi

#======================================-d ^=========-c v=============

	if [ "$c" = "1" ]; then
		fichiersC

#======================================-c ^========-sh v=============

	elif [ "$sh" = "1" ]; then
		fic="$fic.sh"
		echo "#!/bin/bash
#$genMsg

echo 'Hello, World!'" > $way\/$fic
		if [ $? -ne 0 ]; then
			exit 1
		fi

#======================================-sh ^=======-py v=============

	elif [ "$py" = "1" ]; then
		fic="$fic.py"
		echo "#$genMsg

if __name__ == '__main__':

	print(\"Hello, World!\")" > $way\/$fic
		if [ $? -ne 0 ]; then
			exit 1
		fi

#======================================-py ^=========================

	else
		echo -e "// $genMsg\n// Aucune extension de fichier valide saisie.\n" > $way\/$fic
		if [ $? -ne 0 ]; then
			exit 1
		fi
	fi
	chmod $chmod $way\/$fic
	echo "Création du fichier \"$fic\""

#===================================================-o v=============

	if [ "$open" = "1" ]; then
		if [ -z $openCmd ]; then
			subl $way\/$fic
			echo "Ouverture du fichier \"$fic\" sous Sublime Text"
		else
			$openCmd $way\/$fic
			echo "Ouverture du fichier \"$fic\""
		fi
	fi
}

guide() {
	echo -e "  \e[1m#\e[33m======================================================\e[0m\e[1m GUIDE $(basename $0 | tr a-z A-Z) \e[33m======================================================\e[0m\e[1m#\e[0m
  \e[1m\e[33m|																|
  |																|
  |\e[0m	  Le fichier \"$(basename $0)\" est un programme permettant de créer rapidement des fichiers avec ou sans répertoire		\e[1m\e[33m|
  |\e[0m	  avec des permissions pré-réglés ou non.										\e[1m\e[33m|
  |																|
  |																|
  |\e[0m	  \e[4m\e[33mFonctionnement :\e[0m													\e[1m\e[33m|
  |																|
  |\e[0m	  Tout fonctionne par arguments pour avoir l'exécution la plus rapide possible mais le premier peut avoir		\e[1m\e[33m|
  |\e[0m	  plusieurs utilitées :													\e[1m\e[33m|
  |																|
  |\e[0m	  Des droits peuvent être saisis directement en \e[36mpremier argument\e[0m (ex: 642). Ce champ est \e[36mfacultatif\e[0m.			\e[1m\e[33m|
  |\e[0m	  Si des droits ne sont pas saisis, les droits \"755\" seront ceux par défaut.						\e[1m\e[33m|
  |																|
  |\e[0m	  Droits saisis ou pas, la donnée saisit ensuite sera le nom du fichier qui sera créé par la suite et 			\e[1m\e[33m|
  |\e[0m	  est \e[36mnécessaire\e[0m pour le bon fonctionnement du programme.								\e[1m\e[33m|
  |																|
  |\e[0m	  Tous les arguments suivants peuvent ensuite être utilisés dans n'importe quel ordre (sauf pour \"-mkf\") et		\e[1m\e[33m|
  |\e[0m	  ont différentes utilitées décrites ci-après.										\e[1m\e[33m|
  |																|
  |																|
  |\e[0m	  \e[4m\e[33mOptions :\e[0m														\e[1m\e[33m|
  |																|
  |\e[0m	  Par défaut un fichier n'a pas de format mais trois sont pour le moment pris en charges :				\e[1m\e[33m|
  |																|
  |\e[0m		  \e[93m-py\e[0m : créer le fichier en format python (avec un main python) ;						\e[1m\e[33m|
  |\e[0m		  \e[96m-sh\e[0m : créer le fichier en format shell (avec les commandes d'exécution en début de fichier) ;			\e[1m\e[33m|
  |\e[0m		  \e[31m-c\e[0m  : créer tous les fichiers nécessaires au fonctionnement d'un programme c :				\e[1m\e[33m|
  |\e[0m				  un fichier .c, un fichier .h et un fichier test.c avec tout ce qui est nécessaire		\e[1m\e[33m|
  |\e[0m				  à une bonne utilisation déjà prérentré dans ces fichiers.					\e[1m\e[33m|
  |																|
  |\e[0m	  \e[31m-mkf\e[0m : option créant un fichier makefile réservé aux fichiers .c et .h créés.						\e[1m\e[33m|
  |\e[0m			  L'option \"-mkf\" ne peut être saisi \e[36mseulement après les options \"-c\" et \"-t\"\e[0m et le fichier		\e[1m\e[33m|
  |\e[0m			  est déjà prêt à l'emploi.										\e[1m\e[33m|
  |																|
  |\e[0m	  \e[31m-t\e[0m   : option créant toute l'arborescence de répertoire (bin, obj & src où seront les fichiers C)			\e[1m\e[33m|
  |\e[0m			  L'option \"-t\" (pour tree) ne peut être saisi \e[36mseulement après les options \"-c\" et \"-mkf\"\e[0m car		\e[1m\e[33m|
  |\e[0m			  relatif aux fichiers C.										\e[1m\e[33m|
  |																|
  |\e[0m	  \e[32m-d\e[0m   : option créant un répertoire dans lequel sera créé tous les fichiers ainsi créés.				\e[1m\e[33m|
  |\e[0m	  	 Si l'option n'est pas saisit, les fichiers sont créés dans le répertoire courant.				\e[1m\e[33m|
  |\e[0m			  Exemple : \e[36m\"./$(basename $0) toto -c -d\"\e[0m créera les fichiers \"toto.h\", \"toto.c\" et \"testtoto.c\"		\e[1m\e[33m|
  |\e[0m			  \e[36mdans le répertoire\e[0m \"toto\".										\e[1m\e[33m|
  |																|
  |\e[0m	  \e[32m-o\e[0m   : option permettant d'ouvrir tous les fichiers créés (sauf le fichier makefile si créé).				\e[1m\e[33m|
  |\e[0m		 Par défaut, ces fichiers sont ouverts via \e[36m\"Sublime Text\"\e[0m mais vous pourrez par exemple changer cela		\e[1m\e[33m|
  |\e[0m		 directement en entrant à l'argument d'après la commande de votre éditeur de texte favoris.			\e[1m\e[33m|
  |\e[0m			  Exemple : \e[36m\"./$(basename $0) lapin -sh -o gedit\"\e[0m ouvrira le fichier \"lapin.sh sur \e[36m\"éditeur de texte\"\e[0m	\e[1m\e[33m|
  |																|
  |\e[0m	  \e[32m-h\e[0m   : option permettant d'ouvrir ce guide si utilisé en premier argument lors de l'appel du script.			\e[1m\e[33m|
  |\e[0m		 En souvenir des premières version de ce script, l'option \e[36m\"-guide\"\e[0m marche encore.				\e[1m\e[33m|
  |\e[0m			  À savoir aussi que si le guide est ouvert, aucune autre action que ferait le script			\e[1m\e[33m|
  |\e[0m			  dans son fonctionnement normal n'a lieu.								\e[1m\e[33m|
  |																|
  |\e[0m		Une option supplémentaire prenant en charge les fichiers nécessaires aux programmes C++ est à venir...		\e[1m\e[33m|
  |																|
  |																|
  |\e[0m	  \e[4m\e[33mExemples :\e[0m														\e[1m\e[33m|
  |																|
  |\e[0m	  ./$(basename $0) titi -c -mkf -d												\e[1m\e[33m|
  |\e[0m	  ./$(basename $0) 744 tata -o -py												\e[1m\e[33m|
  |\e[0m	  ./$(basename $0) lapin -o gedit -d -sh											\e[1m\e[33m|
  |\e[0m	  ./$(basename $0) 700 nounours -d -c -t -mkf										\e[1m\e[33m|
  |																|
  |																|
  |                                                create.sh V1.4.4 (2021->2023)                                                |
  |							Créé par CPdA-Omi							\e[1m\e[33m|
  \e[0m\e[1m#\e[33m=============================================================================================================================\e[0m\e[1m#\e[0m"
}

#================================================================================Main==================================================================================#

if [ $# -eq 0 ]; then
	echo "Erreur, merci de donner un nom de fichier (./$(basename $0) -h)" >&2
	exit 1
fi

if echo $1 | egrep -q "[0-7]{3}" ; then
	chmod=$1; shift
elif [ "$1" = "-guide" -o "$1" = "-h" ]; then
	guide
	exit 0
else
	chmod="755"
fi

cpt=0; way="."; fic=$1; shift


while [ $# -ne 0 ]; do
	case $1 in
		"-sh")
			if [ -e "$fic.sh" ]; then
				echo "Le fichier \"$fic.sh\" existe déjà dans le répertoire courant"
				exit 1
			else
				if [ $cpt -eq 0 ]; then
					sh=1
					cpt=1
					shift
				else
					echo "Erreur, deux formats de fichier saisit (./$(basename $0) -h)" >&2
					exit 1
				fi
			fi
			;;		

		"-py")
			if [ -e "$fic.py" ] ; then
				echo "Le fichier \"$fic.py\" existe déjà dans le répertoire courant"
				exit 1
			else
				if [ $cpt -eq 0 ]; then
					py=1
					cpt=1
					shift
				else
					echo "Erreur, plusieurs formats formats de fichier saisit (./$(basename $0) -h)" >&2
					exit 1
				fi
			fi
			;;	

		"-c")
			if [ -e "$fic.c" ] ; then
				echo "Le fichier \"$fic.c\" existe déjà dans le répertoire courant" >&2
				exit 1
			else
				if [ $cpt -eq 0 ]; then
					c=1
					cpt=1
					shift
					for i in $1 $2; do
						if [ $i == -t ]; then
							tree=1
							shift
						elif [ $i == -mkf ]; then
							mkf=1
							shift
						fi
					done
				else
					echo "Erreur, plusieurs formats de fichier saisit (./$(basename $0) -h)" >&2
					exit 1
				fi
			fi
			;;

		"-o")
			open=1
			shift
			if [ ! -z $1 ]; then 
				if [ $1 != -* ]; then
					openCmd=$1
					shift
				fi
			fi
			;;

		"-d")
			file=1; shift
			;;

		*)
			echo "Veuillez saisir une option valide (./$(basename $0) -h)" >&2
			exit 1
			;;
	esac
done
if [ -e $fic -a $cpt -eq 0 ]; then
	echo "Le fichier ou le répertoire \"$fic\" existe déjà dans le répertoire courant"
else
	creation
fi
