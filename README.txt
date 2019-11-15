===================================================================Install Docker===================================================================

1. Uninstall old versions
	sudo apt-get remove docker docker-engine docker.io

2. Update the apt package index 
	sudo apt-get update

3. Install packages to allow apt to use a repository over HTTPS

	sudo apt-get install \ apt-transport-https \ ca-certificates \ curl \ software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

4. Add Docker’s official GPG key
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

5. Verify that you now have the key with the fingerprint 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88, 
by searching for the last 8 characters of the fingerprint
	sudo apt-key fingerprint 0EBFCD88

6. Use the following command to set up the stable repository
	sudo add-apt-repository \ "deb [arch=amd64] https://download.docker.com/linux/ubuntu \ $(lsb_release -cs) \ stable"

7. Update the apt package index
	sudo apt-get update

8. Install the latest version of Docker Engine - Community
	sudo apt-get install docker-ce

9. Verify that Docker Engine - Community is installed correctly by running the hello-world image
	sudo docker run hello-world


=======================================================================Install CRIU===================================================================

1.  Enable experimental features
	sudo nano /etc/docker/daemon.json

add following to daemon.json
	{
	"experimental": true
	}
save the contents to daemon.json

2. Restart docker service
	sudo service docker restart

3. To avoid sudo before every docker command
	sudo usermod -a -G docker $USER
	RESTART the session

5. Install CRIU
	sudo apt-get install criu

===================================================================Executing the tasks===================================================================

1. Unzip and copy the directories (task_1 and task_2) submitted in this assignment and run the following commands
2. For task 1, change the directory to the task_1 folder and run the shell script (sh fibo.sh)
3. For task 2, change the directory to the task_2 folder, install bc using the command "apt install bc" and run the shell script (sh checkpoint.sh)  