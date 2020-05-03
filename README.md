# Bwbasic-3.20b

This program will work under Linux and under DOS.

4-16-2020  Updated 4-30-2020 3.20b

Bwbasic has been around since the early 1990's
in one form or another and actually quite powerfull.

This should work under most any Linux and Linux under
WSL (Ubuntu, Debian) for windows at the command prompt.

If running this under Linux you will need 'gcc' compiler.
To see if it's installed type in  gcc --version  if OK
then simply do the following:

tar -xf bwbasic-3.20b.tar

cd <here>

To make 'cls' work as it does in DOS perform once

sudo ln /usr/bin/clear /usr/bin/cls

Tip: Now linking to clear within a bwbasic program you
     can clear the screen using command  SHELL "cls"
     This can be embedded in you program. You can also
     use OPTION TERMINAL ANSI  then use command CLS

Now lets build bwbasic and renum

(1) make
To test before installing (2) make runlocal
Then to install (3) sudo make install
To remove installed programs (4) sudo make remove
To remove compiled programs and recompile (5) make clean

That's it.

bwbasic and renum will be in /usr/local/bin

If you want bwbasic to work from a GUI cd GUI
(1) copy bwbasic.sh to a suitable location
    and make sure to  chmod 755 bwbasic.sh
    so it's executable.
(2) copy bwbasic.png to a suitable location
(3) edit bwbasic.desktop and change references
    for File Location and png location then
    cp bwbasic.desktop to ~/Desktop/.
    and it should work from the desktop.

Doing the above should allow you to click on the icon
on your desktop and start bwbasic.

If running under Windows 10 you will need 'gcc' compiler.
To see if it's installed type in  gcc --version  if you
think you have gcc installed verify your 'PATH' by entering
at the command prompt  echo %PATH% to see if it's there.
If OK then at the command prompt

cd <here>

compile.bat

Read prompts

That's it.

Move bwbasic.exe and renum.exe to locations in your PATH.

There are many, many examples in BAS-EXAMPLES and
available information in INFO.

All should work fine. But as usual no guarentee is implied.

Any references below to relays pertain to the BeagleBone Black.

I have included some runtime files and sample input files.
Place profile.bas in your current working directory and
relays.pro and allon.inp and alloff.inp. The file examples
will let you to by example turn off all relays alloff.inp.
To do this you would enter at the command line:

bwbasic --profile relays.pro --tape alloff.inp relays.bas

To turn all relays on:

bwbasic --profile relays.pro --tape allon.inp relays.bas

To work interactive you would:

bwbasic relays.bas

Once you get a handle on relays.bas commands you can
create you own .inp files and reference them by

bwbasic --profile relays.pro --tape <your file.inp> relays.bas

All the above can placed into a simple script file.

The purpose of relays.pro is to redirect standard and error
outputs to files relays-stdout.txt and relays-error.txt and
to turn off ANSI so the output is easily readable without
escape codes. Using relays.pro then gives you a quiet display
suitable when scripts via .inp is executed.

The purpose of profile.bas which is used by default is to
enable ANSI control sequences so the command 'cls' works
and to set the normal editor to nano which if desired can
bet set to vi. The editor comes into play when creating
or changing a .bas file. To use while running bwbasic you
would issue the command edit.

As a simple example try the guessing game with

bwbasic guess.bas

If you come up with some ideas or enhancements or have a
problem drop me a message keeping in mind my main goal
is to do maintenance updates where necessary.

ken.at.github@gmail.com
Bwbasic-3.20b
