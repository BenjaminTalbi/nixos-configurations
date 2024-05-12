#!/bin/sh
unalias -a
ls
for i in $(ls -d */);
do
  if curl --output /dev/null --silent --head --fail $(cat $i/backgroundurl.txt); then
    echo "$i background successfully downloads";
    echo -n $(curl --output /dev/null --silent --head --fail $(cat $i/backgroundurl.txt)) | sha256sum;
  else
    echo -e "\033[0;31m$i background download fails\033[0m"
fi
done
