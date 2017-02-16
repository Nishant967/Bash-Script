#Generate 10000 curl request to yourwebsitename.com

for i in {1..10000}; do curl -XGET  "http://yourwebsitename.com" & done

#End

