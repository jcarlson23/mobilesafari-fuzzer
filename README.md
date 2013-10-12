mobilesafari-fuzzer
===================

== How to install ==

1. Install zzuf. http://d.pr/f/xDFV

2. Install "file:// for MobileSafari" in Cydia (it's on saurik's repository.)

3. Install safari-refresh. https://github.com/westbaer/safari-refresh

4. Get a random MOV file and place somewhere on your device. `/var/mobile/Media/Safari/original_file.mov` is good.

5. Open Safari on your device and type in `file:///var/mobile/Media/Safari/out.mov`. Nothing should show up (yet.)

5. Install this (msafari-fuzzer), and run it like so

`msafari-fuzzer --infile=/var/mobile/Media/Safari/original_file.mov`

Sit back, relax and enjoy.

(This really sucks, I'm sorry. ;P)

