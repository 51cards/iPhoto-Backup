This script looks for an iPhoto '11 album data file in

    ~/Pictures/iPhoto Library/AlbumData.xml

This is the standard place for iPhoto to store the album data file, so it's very likely you have it here if you have iPhoto.

Recommended use for the script is to copy it to wherever you wish to backup the files to, then invoke it on the command line:

    $ruby iphoto.rb

This will scan the album data file, sort the photos by date, newest first, then copy them to the desired destination until the drive is full. Alternatively, you can manually specify the path you wish to copy to as an argument parameter, in case you want to store the script somewhere else:

    $ruby iphoto.rb /Volumes/Backup

This script was written with exactly one user in mind; that is why it has no other options.

---

 - I have tested this on exactly one iPhoto library: mine. It works for me, but YMMV.
 - The number in front of the files is the "DateAsTimerInterval" value from the album data file. I don't know how to convert it to a "real" date, but sorting by it does sort chronologically, so it's good enough for the purposes of this script.
