echo "-----------------------CREATING IMAGE-----------------------------"
docker build -t fibo .

echo "------------------CREATING & RUNNING CONTAINER----------------------"
docker run --name fibo-con -d fibo

echo "WAITING TIME: "
for i in 10 9 8 7 6 5 4 3 2 1 
do
	echo -n "$i "	
	sleep 1
done

echo "-----------------------PRINTING LOGS---------------------------"
docker logs fibo-con

echo "--------------------CREATING CHECKPOINT----------------------"
docker checkpoint create --leave-running=true fibo-con fibo-check
for i in 8 7 6 5 4 3 2 1 
do
	echo -n "$i "	
	sleep 1
done

echo "--------------------STOPPING CONTAINER--------------------------"
docker stop fibo-con

echo "-----------RESTARTING CONTAINER FROM CHECKPOINT------------------"
docker start --checkpoint fibo-check fibo-con

echo "WAITING TIME: "
for i in 10 9 8 7 6 5 4 3 2 1 
do
	echo -n "$i "	
	sleep 1
done

echo "-------PRINTING LOGS AFTER RESTORE FROM CHECKPOINT------------"
docker logs fibo-con

echo "-------------------REMOVING CHECKPOINT--------------------------"
docker checkpoint rm fibo-con fibo-check
echo "-------------------STOPPING CONTAINER------------------------"
docker stop fibo-con
echo "-------------------REMOVING CONTAINER-----------------------"
docker rm fibo-con
echo "--------------------REMOVING IMAGE-----------------------"
docker rmi -f fibo
echo "------------------------DONE----------------------------------"
