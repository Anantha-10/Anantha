#!/bin/sh
SCORE=0
TEST_1=$(find /home/user/.jenkins/secrets/initialAdminPassword | wc -l)
TEST_2=$(find /home/user/.jenkins/jobs/CompilePipeline/builds -name build.xml -exec grep -o "SUCCESS" {} \; | wc -l)
TEST_3=$(find /home/user/.jenkins/jobs/TestPipeline/builds -name build.xml -exec grep -o "SUCCESS" {} \; | wc -l)
TEST_4=$(grep -io -e "*/5\s\*\s\*\s\*\s\*" -e "clean" -e "compile" -e "https://github.com/frescoplaylab/JenkinsDeliveryPipeline.git" /home/user/.jenkins/jobs/CompilePipeline/config.xml| wc -l)
TEST_5=$(grep -io -e "*/5\s\*\s\*\s\*\s\*" -e "test" -e "https://github.com/frescoplaylab/JenkinsDeliveryPipeline.git" -e "SUCCESS" /home/user/.jenkins/jobs/TestPipeline/config.xml| wc -l)
TEST_6=$(find /home/user/.jenkins/workspace/TestPipeline/target/surefire-reports/*.xml | wc -l)
if [ "$TEST_1" -eq 1 ]
then SCORE=$(($SCORE + 15))
fi;
if [ "$TEST_2" -ge 1 ]
then SCORE=$(($SCORE + 15))
fi;
if [ "$TEST_3" -ge 1 ]
then SCORE=$(($SCORE + 15))
fi;
if [ "$TEST_4" -ge 4 ]
then SCORE=$(($SCORE + 20))
fi;
if [ "$TEST_5" -ge 4 ]
then SCORE=$(($SCORE + 20))
fi;
if [ "$TEST_6" -eq 1 ]
then SCORE=$(($SCORE + 15))
fi;
echo "FS_SCORE:$SCORE%"