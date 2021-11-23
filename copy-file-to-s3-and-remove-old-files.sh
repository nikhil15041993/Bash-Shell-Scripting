#!/bin/bash


#UPLOADING NEW FILES TO S3 BUCKET

sudo aws s3 cp /var/www/html s3://nikhilclibucket --recursive >/dev/null 2>&1
              if [ $? == 0 ]
              then
              echo "UPLOAD SUCCESS"
              else
              echo "UPLOAD FAILD"
              fi

#DELETING OLD FILES FROM S3 BUCKET

aws s3 ls s3://nikhilclibucket --recursive | while read -r  line; 
do
	createdate=`echo $line|awk {'print $1'}`
	createdate=`date -d "$createdate" +%s`
        today=$(date +%s)
        count=$(( ($today-$createdate) / 86400 ))
	if [ $count -gt 7 ]
	then
              aws s3 rm s3://nikhilclibucket/ --recursive  --include "$line*" >/dev/null 2>&1
              if [ $? == 0 ]
              then
              echo "DELETE SUCCESULL"
              break
              else
              echo "DELETE FAILD"
              fi
           
        else
        echo "" >/dev/null 2>&1
fi         
done;
	
