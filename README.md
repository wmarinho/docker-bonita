docker-bonita
=============
<pre>
docker run --name=postgres -d -p 5432:5432 wmarinho/postgresql:9.3
docker run  --name=bonita -d  -p 8080:8080  -e  RDS_PORT=5432  -e RDS_DB_NAME=postgres  -e RDS_USERNAME=pgadmin  -e RDS_HOSTNAME=localhost  -e RDS_PASSWORD=pgadmin. -e DB_VENDOR=postgres wmarinho/bonita:6.3.2
</pre>
