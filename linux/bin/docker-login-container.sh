#/bin/bash
if [ $# -ne 1 ]; then
	echo "container name required!"
	exit
fi

container=$1
echo "container" $container
docker exec -it $container sh
