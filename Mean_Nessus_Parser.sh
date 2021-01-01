#!/bin/bash

####################################################################################################
# csvkit is works on Python versions 2.6, 2.7, 3.3 and 3.4, as well as PyPy. Supports OSX and Linux. 
# Run sudo pip install csvkit to install csvkit parser.
# Installing csvkit:
# pip install csvkit
####################################################################################################


####################################################################################################
# Developer hints...
# If you are a developer that also wants to hack on csvkit, install it this way:
# git clone git://github.com/onyxfish/csvkit.git
# cd csvkit
# mkvirtualenv csvkit
# If running Python 2
# pip install -r requirements-py2.txt
# If running Python 3
# pip install -r requirements-py3.txt
# python setup.py develop
# tox
####################################################################################################

####################################################################################################
# Adding ASCI ART
####################################################################################################

base64 -d <<< "ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfLi0tIiIiLS0sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4nICAgICAgICAgIGBcCiAgLi0iIiIiIiItLiAgICAgICAgICAgICAgICAgICAgICAuJyAgICAgICAgICAgICAgfAogLyAgICAgICAgICAnLiAgICAgICAgICAgICAgICAgICAvICAgICAgICAgICAgLi0uXy8KfCAgICAgICAgICAgICBgLiAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgIHwKIFwgICAgICAgICAgICAgIFwgICAgICAgICAgLi0uXyB8ICAgICAgICAgIF8gICBcCiAgYCIiJy0uICAgICAgICAgXF8uLS4gICAgIFwgICBgICAgICAgICAgICggXF9fLwogICAgICAgIHwgICAgICAgICAgICAgKSAgICAgJz0uICAgICAgIC4sICAgXCAgCiAgICAgICAvICAgICAgICAgICAgICggICAgICAgICBcICAgICAvICBcICAvCiAgICAgL2AgICAgICAgICAgICAgICBgXCAgICAgICAgfCAgIC8gICAgYCcKICAgICAnLi4tYFwgICAgICAgIF8uLS4gYFwgXy5fXy8gICAuPS4KICAgICAgICAgIHwgIF8gICAgLyBcICAnLi1gICAgIGAtLicgIC8KICAgICAgICAgIFxfLyB8ICB8ICAgJy4vIF8gICAgIF8gIFwuJwogICAgICAgICAgICAgICAnLScgICAgfCAvICAgICAgIFwgfCAgCiAgICAgICAgICAgICAgICAgICAgICB8ICAuLS4gLi0uICB8ICAgUGFyc2UgdGhhdCBtZWFuIE5lc3N1cyBmaWxlCiAgICAgICAgICAgICAgICAgICAgICBcIC8gb3wgfG8gXCAvICAgCiAgICAgICAgICAgICAgICAgICAgICAgfCAgIC8gXCAgIHwgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgIC8gYCJgICAgYCJgIFwKICAgICAgICAgICAgICAgICAgICAgLyAgICAgICAgICAgICBcCiAgICAgICAgICAgICAgICAgICAgfCAnLl8uJyAgICAgICAgIFwKICAgICAgICAgICAgICAgICAgICB8ICAvICAgICAgICAgICAgIHwKICAgICAgICAgICAgICAgICAgICAgXCB8ICAgICAgICAgICAgIHwKICAgICAgICAgICAgICAgICAgICAgIHx8ICAgIF8gICAgXyAgIC8KICAgICAgICAgICAgICAgICAgICAgIC98XCAgKF9cICAvXykgLwogICAgICAgICAgICAgICAgICAgICAgXCBcJy5fICBgICdfLic="

printf "\n"
printf "\n"
printf "By Lamehacker -- Free Industries\n"
printf "\n"

####################################################################################################
# Setting colors
####################################################################################################

YELLOW='\033[0;33m' # Errors
CYAN='\033[0;36m' # Info
PURPLE='\033[0;35m' # Tips
RED='\033[0;31m' # Success
NC='\033[0m' # No Color

####################################################################################################
# Check for csvkit prereqs
####################################################################################################

check_pre() {

	printf  "${CYAN} Checking prerequisites....${NC} \n"

	if ! dpkg-query -l csvkit  > /dev/null; then
	
		printf "${YELLOW} csvkit library not found! Install? (y/n)${NC}\n"

	        read
		
		if "$REPLY" = "y"; then

        		printf "${CYAN}Installing csvkit using apt-get...you can also do with pip ${NC}\n"
	        
				sudo apt-get update -y
	        	        sudo apt-get install csvkit
		
		fi

		else
        
			printf "${RED}--- csvkit library installed! ---${NC}\n"

	fi

}

check_error() {

	printf "####################################################################################################\n"
	printf "${CYAN} Checking *.csv file for error using csvclean, edit for advanced option ${NC}\n"
	printf "####################################################################################################\n"
	printf "\n"

	csvclean -n $1 
}

print_look() {

	printf "####################################################################################################\n"
	printf "${CYAN} This is a preview of the info for exploitation... ${NC}\n"
	printf "####################################################################################################\n"
	printf "\n"

	csvcut -c Risk,Host,Protocol,Port,CVE,Metasploit $1 | csvsort -c Metasploit | csvlook | less -S
}

exploit_info() {

        printf "####################################################################################################\n"
        printf "${CYAN} Exporting csv file with host,port,CVE and Metasploit  columns... ${NC}\n"
        printf "####################################################################################################\n"
        printf "\n"

        csvcut -c Risk,Host,Protocol,Port,CVE,Metasploit $1 | csvsort -c  Metasploit > $(date "+%Y.%m.%d-%H.%M.%S")-Exploit_parsed_nessus.csv

        printf "\n${RED} Done... ${NC}\n"
}

filter_col() {

	printf "####################################################################################################\n"
	printf "${CYAN} Exporting csv file with Risk,Name,Synopsis,Host,Protocol,Port,CVE columns... ${NC}\n"
	printf "####################################################################################################\n"
	printf "\n"

	csvcut -c Risk,Name,Synopsis,Host,Protocol,Port,CVE $1 | csvsort -c Risk > $(date "+%Y.%m.%d-%H.%M.%S")-All_parsed_nessus.csv
	
	printf "\n${RED} Done... ${NC}\n"

        printf "####################################################################################################\n"
        printf "${CYAN} Exporting csv file with Risk,Name,Synopsis,Host,Protocol,Port,CVE columns only Critical... ${NC}\n"
        printf "####################################################################################################\n"
        printf "\n"

	csvcut -c Risk,Name,Synopsis,Host,Protocol,Port,CVE $1 | csvgrep -c Risk -m Critical | csvsort -c Name > $(date "+%Y.%m.%d-%H.%M.%S")-Critical_parsed_nessus.csv

	printf "\n${RED} Done... ${NC}\n"

	printf "####################################################################################################\n"
        printf "${CYAN} Exporting csv file with Risk,Name,Synopsis,Host,Protocol,Port,CVE columns only High... ${NC}\n"
        printf "####################################################################################################\n"
        printf "\n"

        csvcut -c Risk,Name,Synopsis,Host,Protocol,Port,CVE $1 | csvgrep -c Risk -m High | csvsort -c Name > $(date "+%Y.%m.%d-%H.%M.%S")-High_parsed_nessus.csv

	printf "\n${RED} Done... ${NC}\n"

        printf "####################################################################################################\n"
        printf "${CYAN} Exporting csv file with Risk,Name,Synopsis,Host,Protocol,Port,CVE columns only Medium... ${NC}\n"
        printf "####################################################################################################\n"
        printf "\n"

	csvcut -c Risk,Name,Synopsis,Host,Protocol,Port,CVE $1 | csvgrep -c Risk -m Medium | csvsort -c Name > $(date "+%Y.%m.%d-%H.%M.%S")-Medium_parsed_nessus.csv

	printf "\n${RED} Done... ${NC}\n"

        printf "####################################################################################################\n"
        printf "${CYAN} Exporting csv file with Risk,Name,Synopsis,Host,Protocol,Port,CVE columns only Low... ${NC}\n"
        printf "####################################################################################################\n"
        printf "\n"

	csvcut -c Risk,Name,Synopsis,Host,Protocol,Port,CVE $1 | csvgrep -c Risk -m Low | csvsort -c Name > $(date "+%Y.%m.%d-%H.%M.%S")-Low_parsed_nessus.csv

	printf "\n${RED} Done... ${NC}\n"

        printf "####################################################################################################\n"
        printf "${CYAN} Exporting csv file with IP column only... ${NC}\n"
        printf "####################################################################################################\n"
        printf "\n"

        csvcut -c Host $1 | sort -u  > $(date "+%Y.%m.%d-%H.%M.%S")-IPs_parsed_nessus.csv

	printf "\n${RED} Done... ${NC}\n"

        printf "####################################################################################################\n"
        printf "${CYAN} Exporting csv file with Name column only... ${NC}\n"
        printf "####################################################################################################\n"
        printf "\n"

        csvcut -c Name $1 | sort -u  > $(date "+%Y.%m.%d-%H.%M.%S")-Names_parsed_nessus.csv

        printf "\n${RED} Done... ${NC}\n"

        printf "####################################################################################################\n"
        printf "${CYAN} Exporting csv file with Port column only... ${NC}\n"
        printf "####################################################################################################\n"
        printf "\n"

        csvcut -c Port $1 | sort -u  > $(date "+%Y.%m.%d-%H.%M.%S")-Ports_parsed_nessus.csv

        printf "\n${RED} Done... ${NC}\n"
}

get_stats() {

	printf "####################################################################################################\n"
	printf "${CYAN} Printing stats per column: Host,Risk,Port,CVE ${NC}\n"
	printf "####################################################################################################\n"
	printf "\n"
	
	printf "####################################################################################################\n"
	printf "Showing Critical issues:\n"
	csvcut -c Risk,Name,Host,Port,CVE $1 | csvgrep -c Risk -m Critical | csvsort -c Name | csvlook | more 
	printf "Counting Critical issues:\n"
        csvcut -c Risk $1 | csvgrep -c Risk -m Critical | csvlook | wc -l  
        printf "####################################################################################################\n"
	printf "Showing High issues:\n"
        csvcut -c Risk,Name,Host,Port,CVE $1 | csvgrep -c Risk -m High | csvsort -c Name | csvlook | more
        printf "Counting High issues:\n"
        csvcut -c Risk $1 | csvgrep -c Risk -m High | csvlook | wc -l
	printf "####################################################################################################\n"
        printf "Showing Medium issues:\n"
        csvcut -c Risk,Name,Host,Port,CVE $1 | csvgrep -c Risk -m Medium | csvsort -c Name | csvlook | more
        printf "Counting Medium issues:\n"
        csvcut -c Risk $1 | csvgrep -c Risk -m Medium | csvlook | wc -l
	printf "####################################################################################################\n"
        printf "Showing Low issues:\n"
        csvcut -c Risk,Name,Host,Port,CVE $1 | csvgrep -c Risk -m Low | csvsort -c Name | csvlook | more
        printf "Counting Low issues:\n"
        csvcut -c Risk $1 | csvgrep -c Risk -m Low | csvlook | wc -l
	printf "####################################################################################################\n"
        printf " Output lists of frequent values:\n"
        csvcut -c Risk,Host,Port,CVE $1 | csvstat --freq
}

print_help() {

	printf "${PURPLE} \t usage: moose:
		\t [-h] [-f RISK,HOST,PORT,NAME COLUMNS] \n
		\t [-e CHECK ERRORS] [-l CHECK LOOK] [-c CHECK PRE REQ] \n
		\t [-s RISK,HOST,PORT,NAME COLUMN STATS] [FILE] ${NC}\n"
        printf "\n"
        printf "${RED}*Tips: Export Nessus report in a csv format with all the info provided.${NC}\n"
	printf "\n"
	printf "${PURPLE} -h: Prints this help message.${NC}\n"
	printf "${PURPLE} -x: Exports a csv file with the columns needed to exploit the host.${NC}\n"
        printf "${PURPLE} -f  Exports a csv file with the columns Risk,Host,Protocol,Port,Name,CVE,sorted by Risk.${NC}\n"
        printf "${PURPLE} -c: Checks if csvkit library is installed.${NC}\n"
	printf "${PURPLE} -e: Checks and cleans a CSV file of common syntax errors.${NC}\n"
	printf "${PURPLE} -l: Print csv preview.${NC}\n"
	printf "${PURPLE} -s: Print stats per columns - Risk,Host,Protocol,Port,Name,CVE${NC}\n"
	printf "\n"
}

###################################################################################
# Run script normally 
##################################################################################

while getopts 'he:cs:l:f:x:' OPTION; do

	case "$OPTION" in

		c)

			check_pre $OPTARG
			exit 1
			;;
		e)
			check_error $OPTARG
			exit 1
			;;

		l)       
			print_look $OPTARG
			exit 1
			;;

		f)	
			filter_col $OPTARG
			exit 1
			;;
		
		s)
			get_stats $OPTARG
			exit 1
			;;
                x)
	                exploit_info $OPTARG
                        exit 1
                        ;;

		h)
			print_help $OPTARG
			exit 1
			;;

		?)

			echo "Invalid command, please try again"
			;;
	esac
done

shift "$((OPTIND-1))"
