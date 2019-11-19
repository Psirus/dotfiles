for dir in Bilder Code Dokumente Downloads Scrap Thesis Videos Wiki
do
    rsync -r -P -u --delete $dir Netzwerk/DriveM/
done
