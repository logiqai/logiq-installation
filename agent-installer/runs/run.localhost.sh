#!/usr/bin/sh
# example logiqcoll.sh wrapper

../logiqcoll/logiqcollinst2 \
	--endpoint "127.0.0.1" \
	--ossip "121.100.36.228" \
	--osspasswd "deadbeef4fdd68fecb88d952b6bb9aff" \
	--ingetoken "deadbeefOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2Nlc3MiOltdLCJhdWQiOiJsb2dpcS1jbGllbnRzIiwianRpIjoiMGY4MTYyMWYtNWUxOS00MjFkLTkxNWYtNDRlOGI3YmU3Zjg2IiwiaWF0IjoxNjc5NjEzMjYxLCJpc3MiOiJsb2dpcS1jb2ZmZWUtc2VydmVyIiwibmJmIjoxNjc5NjEzMjYxLCJzdWIiOiJmbGFzaC1hZG1pbkBmb28uY29tIiwiVWlkIjoxLCJyb2xlIjoiYWRtaW4ifQ.KTkj4UIloMWAQeHLPG9qYxzXog8g7vh5q4VKqWU3udjNFOV22Q2pxkrHntnFR4GYMZgrPRVomE75B_hqTTMhd4yhSkc4Xuy74GFpP7Z2Dy5gBmumiCznw8rbPBFGX0ujy8bBa6eW2wwOsMgwTbVusoNETC2ow6ZIWHneP-w_Si_5V4Zyjih9GgtXxeJQHfdqO1yXkyoXRKI4OtsAqlS7ZgE7NgN_99fdI3cVPYidEbqO9u_x3LRVjd4tax114_ldxaEzoqqNd9GitIp9ang9GhTwQtlboa_9PzWTIZa14j6JT8mEpRxv5tWgkXFXxID2syW2bGWSEO4dvpgQd8Zc4w" \
	--instmap 1,1,1,1,1 \
	--instauth \
	--cluster_id logiq \
	--namespace engr \
	--tenant_id customer_id \
	--tenant tenant  

