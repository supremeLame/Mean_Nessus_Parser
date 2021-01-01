![Image](http://www.how-to-draw-cartoons-online.com/image-files/cartoon_moose.gif "icon")

Mean_Nessus_Parser_v1.0
======
**Mean_Nessus_Parser_v1.0** is a simple bash script accepting as an input a Nessus CSV output. This tools is using the Python CSV library to run properly (csvtkit). With this tool you can categorise the your finding to Critical, High, Low, see the exploitable findings etc. For more information see the code.

## Download
* [Version 1.0](https://github.com/supremeLame/Solidity_Require_Use.git)

## Usage
---
```
$ git clone https://github.com/supremeLame/Mean_Nessus_Parser.git
$ chmod +x Mean_Nessus_Parser.sh
$ ./Mean_Nessus_Parser.sh -h
                                      _.--"""--,
                                    .'          `\
  .-""""""-.                      .'              |
 /          '.                   /            .-._/
|             `.                |             |
 \              \          .-._ |          _   \
  `""'-.         \_.-.     \   `          ( \__/
        |             )     '=.       .,   \  
       /             (         \     /  \  /
     /`               `\        |   /    `'
     '..-`\        _.-. `\ _.__/   .=.
          |  _    / \  '.-`    `-.'  /
          \_/ |  |   './ _     _  \.'
               '-'    | /       \ |  
                      |  .-. .-.  |   Parse that mean Nessus file
                      \ / o| |o \ /   
                       |   / \   |            
                      / `"`   `"` \
                     /             \
                    | '._.'         \
                    |  /             |
                     \ |             |
                      ||    _    _   /
                      /|\  (_\  /_) /
                      \ \'._  ` '_.'

By Lamehacker -- Free Industries

 	 usage: moose:
			 [-h] [-f RISK,HOST,PORT,NAME COLUMNS] 

			 [-e CHECK ERRORS] [-l CHECK LOOK] [-c CHECK PRE REQ] 

			 [-s RISK,HOST,PORT,NAME COLUMN STATS] [FILE] 

*Tips: Export Nessus report in a csv format with all the info provided.

 -h: Prints this help message.
 -x: Exports a csv file with the columns needed to exploit the host.
 -f  Exports a csv file with the columns Risk,Host,Protocol,Port,Name,CVE,sorted by Risk.
 -c: Checks if csvkit library is installed.
 -e: Checks and cleans a CSV file of common syntax errors.
 -l: Print csv preview.
 -s: Print stats per columns - Risk,Host,Protocol,Port,Name,CVE
```

## Contributors
---
supremeLame

## Version 
---

* Version 1.0

## Contact
---

* Blog page: https://securityhorror.blogspot.com/
