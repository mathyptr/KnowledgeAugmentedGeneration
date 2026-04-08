#Crea il Backup  dei volumi
docker run --rm --mount source=docker_openspg-minio_data,target=/mount_point -v $(pwd):/backup busybox tar -czvf /backup/docker_openspg-minio_data.tar.gz /mount_point

docker run --rm --mount source=docker_openspg-mysqldb,target=/mount_point -v $(pwd):/backup busybox tar -czvf /backup/docker_openspg-mysqldb.tar.gz /mount_point

docker run --rm --mount source=docker_openspg-neo4j_dozerdb_logs,target=/mount_point -v $(pwd):/backup busybox tar -czvf /backup/docker_openspg-neo4j_dozerdb_logs.tar.gz /mount_point


#Crea il Backup  delle immagini
docker commit -p release-openspg-server release-openspg-server
docker commit -p release-openspg-minio release-openspg-minio
docker commit -p release-openspg-mysql release-openspg-mysql
docker commit -p release-openspg-neo4j release-openspg-neo4j

docker save -o release-openspg-server.tar release-openspg-server
docker save -o release-openspg-minio.tar release-openspg-minio
docker save -o release-openspg-mysql.tar release-openspg-mysql
docker save -o release-openspg-neo4j.tar release-openspg-neo4j
