#!/bin/bash
#---------------------------------------------------------------------------------------#
EXEC_JAR='target/scala-2.11/spark-scylla-counter_2.11-1.0.jar'
#---------------------------------------------------------------------------------------#
if [ -z "$1" ]; then

  echo "+-----------------------------------------------+"
  echo "|  0. Build                                     |"
  echo "+-----------------------------------------------+"
  echo "|  1. Total Links                               |"
  echo "|  2. Total Visited Domains                     |"
  echo "+-----------------------------------------------+"
  echo "|  3. Export Target Urls                        |"
  echo "|  4. Reading File                              |"
  echo "|  5. Export Health Links                       |"
  echo "+-----------------------------------------------+"

#---------------------------------------------------------------------------------------#
elif [ "$1" == "0" ]; then
    # sbt compile
    sbt clean package
    # sbt assembly 


#---------------------------------------------------------------------------------------#
elif [ "$1" == "1" ]; then
spark-submit    		\
  --class "Links"           	\
  --master local[16]        	\
  --driver-memory   64G     	\
  --executor-memory 64G     	\
  ${EXEC_JAR} 

#---------------------------------------------------------------------------------------#
elif [ "$1" == "2" ]; then
spark-submit    		\
  --class "VisitedDomains"	\
  --master local[16]        	\
  --driver-memory   64G     	\
  --executor-memory 64G     	\
  ${EXEC_JAR} 
  target/scala-2.11/spark-cassandra-count_2.11-1.0.jar  



#---------------------------------------------------------------------------------------#
elif [ "$1" == "3" ]; then
spark-submit    		\
  --class "ExportTargetUrls"    \
  --master local[16]            \
  --driver-memory   64G         \
  --executor-memory 64G         \
  ${EXEC_JAR}			\
  data/target.dat 

  
#---------------------------------------------------------------------------------------#
elif [ "$1" == "4" ]; then
spark-submit    		\
  --class "Files"           	\
  --master local[16]        	\
  --driver-memory   64G     	\
  --executor-memory 64G     	\
  ${EXEC_JAR}			\
  data/diseases.dat 

#---------------------------------------------------------------------------------------#
elif [ "$1" == "5" ]; then
spark-submit			\
  --class "ExportLinks"     	\
  --master local[16]        	\
  --driver-memory   64G     	\
  --executor-memory 64G     	\
  ${EXEC_JAR}			\
  data/health1.dat 

fi
#---------------------------------------------------------------------------------------#

