#Restore delle immagini
docker image load -i release-openspg-server.tar 
docker image load -i release-openspg-mysql.tar 
docker image load -i release-openspg-neo4j.tar 
docker image load -i release-openspg-minio.tar 


#Restore dei Volumi
docker run --rm --mount source=docker_openspg-minio_data,target=/mount_point -v $(pwd):/backup busybox tar -xzvf /backup/docker_openspg-minio_data.tar.gz -C /

docker run --rm --mount source=docker_openspg-mysqldb,target=/mount_point -v $(pwd):/backup busybox tar -xzvf /backup/docker_openspg-mysqldb.tar.gz -C /

docker run --rm --mount source=docker_openspg-neo4j_dozerdb_logs,target=/mount_point -v $(pwd):/backup busybox tar -xzvf /backup/docker_openspg-neo4j_dozerdb_logs.tar.gz -C /

