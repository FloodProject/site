require "tools/helpers"

function cleanDockerContainers()
	info("Cleaning all stopped Docker containers")
	os.execute('sudo docker rm $(sudo docker ps -a -q)')
end

function cleanDockerImages()
	info("Cleaning all untagged Docker images")
	os.execute('sudo docker rmi $(sudo docker images | grep "^<none>" | awk "{print $3}")')
end

cleanDockerContainers()
cleanDockerImages()