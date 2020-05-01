    2 rem Relays control program in bwbasic 3.2 4-18-2020 ken.at.github@gmail.com
    3 rem 4-18-2020 Added hardware check. Error traps and help.
    4 rem As of 4-13-2020 Debian apt get install bwbasic installs an old 2.2.
    5 rem Assumes bwbasic 3.2. bwbasic 2.2 has issues see changelog.
    6 rem Download bwbasic-3.2a.tar file. Untar then cd bwbasic-3.2a then
    7 rem make  then  sudo make install to uninstall sudo make remove
    8 rem Set terminal to ANSI mode. Linux and Windows. Only 3.2 or newer
   10 option terminal ANSI
   11 call cls
    : rem Clear screen on initial startup. Only 3.2 or newer
   12 call close
    : rem Close any open files. Again 3.2 or newer.
   13 rem Trap errors
   14 on error gosub 10000
   15 gosub 9000
    : rem Get Dogtag & Model & see if it's allowable hardware.
   16 print
    : print "=== Relay games on ";DATE$;" at ";TIME$;" ==="
    : print " ";d$
   17 print "        ";o$
   18 print
   24 rem b$ = Base address as of Beaglebone Black Debian 10.3 3-26-2020
   25 let b$="/sys/class/gpio/gpio"
   50 print "0 Off, 1 On, s State, sa State All,";
   52 print " ao All Off, l Label, h for Help or x Exit ";
    : input m$
   60 IF m$ = "0" or m$ = "1" or m$ = "l" or m$ = "s" then
    :   goto 70
    : END IF
   63 IF m$ = "x" or m$ = "e" then
    :   system
    : END IF
    : rem   Stop program. Exit to system.
   64 IF m$ = "sa" then
    :   print
    :   print "Currently:"
    :   gosub 500
    :   goto 16
    : END IF
    : rem State all
   65 IF m$ = "ao" then
    :   print
    :   print "Was:"
    :   gosub 500
    :   print "Now:"
    :   gosub 600
    :   goto 16
    : END IF
   66 IF m$ = "q"  then
    :   print "Bye"
    :   stop
    : END IF
    : rem   Stop program
   67 IF m$ = "h"  then
    :   gosub 1000
    :   goto 16
    : END IF
   68 print "Mode error. Only 0, 1, s, l, ao All Off, sa State All ";
   69 print "h Help or x allowed"
    : goto 50
   70 print "Relay # = gpio: 1 = 20, 2 = 7, 3 = 112, 4 = 115 or r to Return. ";
   71 input "Enter gpio # ";s$
   75 IF s$ = "20" or s$ = "7" or s$ = "112" or s$ = "115" then
    :   goto 80
    : END IF
   76 IF s$ = "r" then
    :   goto 16
    : END IF
    : rem Start over
   78 print "Relay gpio number error. Only 20, 7, 112, 115 or r"
    : goto 70
   80 print
   82 IF m$ = "l" then
    :   gosub 400
    :   goto 16
    : END IF
    : rem     l = Label
   84 IF m$ = "s" then
    :   gosub 300
    :   print
    :   goto 16
    : END IF
    : rem     s = State
   86 IF m$ = "0" or m$ = "1" then
    :   gosub 100
    :   goto 16
    : END IF
    : rem Change Relay state
   90 print
    : print "Error. Code fall through at line 90"
    : print
    : stop
  100 rem Change state of a Relay.
  101 rem p$ = Complete address to gpio. b$ is the Base + gpio# + end of string
  102 let p$=b$ + s$ + "/value"
  110 call open("O",#1,p$)
    : rem Open for Output and write m$
  150 print #1,m$
    : rem          Print to gpio string m$
  160 call close(#1)
  210 call open("I",#1,p$)
    : rem  Open for Input
  250 read #1,x
    : rem             Read numeric result
  255 call close(#1)
  256 IF s$ = "20"  then
    :   print "#1 ";
    : END IF
  257 IF s$ = "7"   then
    :   print "#2 ";
    : END IF
  258 IF s$ = "112" then
    :   print "#3 ";
    : END IF
  259 IF s$ = "115" then
    :   print "#4 ";
    : END IF
  260 gosub 700
  299 return
  300 rem p$ = Complete address to gpio. b$ is the Base + gpio# + end of string
  304 let p$=b$ + s$ + "/value"
  310 call open("I",#1,p$)
    : rem Open for Input
  350 read #1,x
    : rem            Read numeric result
  355 call close(#1)
  360 gosub 700
  396 return
    : rem Start over
  400 rem p$ = Complete address to gpio. b$ is the Base + gpio# + end of string
  404 let p$=b$ + s$ + "/label"
  410 call open("I",#1,p$)
  420 read #1,l$
  425 call close(#1)
  430 print "Label for gpio ";s$;" is ";l$
  440 return
  500 rem Display the state of all Relays 'sa'
  510 let s$ = "20"
    : print "#1 ";
    : gosub 300
  520 let s$ = "7"
    : print "#2 ";
    : gosub 300
  530 let s$ = "112"
    : print "#3 ";
    : gosub 300
  540 let s$ = "115"
    : print "#4 ";
    : gosub 300
  550 return
  600 rem Turn all Relays off 'ao'
  612 let m$ = "0"
    : rem Set mode to '0' off
  620 let s$ = "20"
    : gosub 100
  624 let s$ = "7"
    : gosub 100
  626 let s$ = "112"
    : gosub 100
  628 let s$ = "115"
    : gosub 100
  630 return
  700 rem Print relay state gathered from 'read'
  704 print "Relay gpio ";s$," state is now = ";x;
  770 IF x = 0 then
    :   print " Off"
    : END IF
  780 IF x = 1 then
    :   print " On"
    : END IF
  790 IF x > 1 or x < 0 then
    :   print " Error"
    : END IF
  799 return
 1000 rem Give them some help
 1010 print
    : print "Information"
    : print
 1020 print "To change the state of a relay use 0 for Off or 1 for On"
 1022 print "   Then enter the gpio number 20, 7, 112 or 115"
    : print
 1024 print "To check the state of a single relay use s"
 1026 print "   Then enter the gpio number"
    : print
 1028 print "To get the associated label (header pin) use l"
 1030 print "   Then enter the gpio number"
    : print
 1032 print "To get the state of all relays use sa"
    : print
 1034 print "To turn all relays off use ao"
    : print
 1035 print "For the latest updates goto:"
 1036 print "https://github.com/kenmartin-unix/Bwbasic-3.2a-for-BeagleBone"
 1038 print "ken.at.github@gmail.com"
 1040 print
    : input "Press enter ? ",h
 1099 return
 9000 rem  Get Model & Dogtag d$ = Dogtag 0$ = MOdel. Check for Beaglebone 'Black'
 9002 rem If we fail here we should not. This only runs once at startup.
 9004 call open("I",#1,"/etc/dogtag")
    : rem             Open dogtag file
 9008 read #1,d$
    : call close(#1)
 9014 call open("I",#1,"/proc/device-tree/model")
    : rem Open model info
 9018 read #1,o$
    : call close(#1)
 9020 rem Lets see if it's a 'Black'
 9025 IF (instr(1,o$,"Black") > 0) then
    :   return
    : END IF
 9055 print
    : print "Warning: It appears this is not a BeagleBone 'Black'"
    : print
 9056 print "It appears to be : ";o$
 9057 print "Running : ";d$
 9058 system
10000 rem Trap errors here. Hopefuly you will not get here.
10020 print
    : print "Error code ";err;" Error line ";erl
10040 print
10041 IF (err = 2)   then
    :   print "A program syntax error."
    :   print
    :   system
    : END IF
10042 IF (err = 5)   then
    :   print "Trouble working with files."
    :   print
    :   system
    : END IF
10043 IF (erl > 9000) then
    :   print "Trouble during initial setup."
    :   print
    :   system
    : END IF
10044 IF (err = 62)  then
    :   print "Reading past the end of file attempted."
    :   print
    : END IF
10048 IF (err = 64)  then
    :   print "Invalid path. Verify open paths."
    :   system
    : END IF
10060 rem CLOSE will fail on 2.2 and loop but not 3.2+
10070 call close
    : rem Just in case something is open.
11100 system
    : rem Stop program

