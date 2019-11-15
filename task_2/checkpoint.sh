echo "#Process,#Iteration,Checkpoint time" > ./result/checkpoint_time.csv
echo "#Process,#Iteration,Restore time" > ./result/restore_time.csv
echo "#Process,Avg. checkpoint time,Avg. restore time" > ./result/avg.csv
for img in 1 5 10 15 20 25 30 35 40 45 50
do
  image="image_${img}" 
  echo "-------------------CREATING IMAGE with ${img} processes---------------------"
  
  docker build -t $image .
  
  c_final=0
  r_final=0

  for itr in 1 2 3 4 5
  do
  
    container="cont_${img}_${itr}"
    
    echo "-----------CREATING CONTAINER ${itr} for ${img} process machine-----------"
    
    docker run --name $container -d $image ${img}
    
    START_C=$(date +%s.%N)
    docker checkpoint create  --leave-running=true $container chkpoint
    END_C=$(date +%s.%N)
    DIFF_C=$(echo "$END_C - $START_C" | bc)
    echo "${img},${itr},${DIFF_C}" >> ./result/checkpoint_time.csv
    docker stop $container
    START_R=$(date +%s.%N)
    docker start --checkpoint chkpoint $container
    END_R=$(date +%s.%N)
    DIFF_R=$(echo "$END_R - $START_R" | bc)
    echo "${img},${itr},${DIFF_R}" >> ./result/restore_time.csv
    docker stop $container
    docker checkpoint rm $container chkpoint
    docker rm $container
    c_final=$(echo "$c_final + $DIFF_C" | bc)
    r_final=$(echo "$r_final + $DIFF_R" | bc)
    echo "---------------------------------------------------------------------------"
  
  done
  docker rmi -f $image
  
  c_final=$(echo "scale=5; $c_final/5" | bc)
  r_final=$(echo "scale=5; $r_final/5" | bc)
  
  echo "${img},${c_final},${r_final}" >> ./result/avg.csv
  echo "=============================================================================="

done
