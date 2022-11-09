# Create your grading script here

# set -e means stops the script from running if there is an error
set -e

# deleting directory in case it exists
rm -rf student-submission

# git clone into directory called student-submission 
git clone $1 student-submission

# go to student-submission directory
cd student-submission

# check if the correct file has been submitted 
if [[ -e ListExamples.java ]]
then
    echo "Correct File"
else 
    echo "Incorrect File"
    exit 1  
fi 

# copy ListExamples.java to parent directory 
cp ListExamples.java ../ 
cd ../ 

# turning off errors 
set +e 

# compile tests 
CPATH = ".:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar" 

javac -cp $CPATH *.java 2> err1.txt  

#turn back on errors 
set -e 

# checking if compilation is successful 
if [[ $? -eq 00 ]]
then 
    echo "Compile Successful"
else 
    echo "Compile Unsuccessful"
    exit 1
fi 


# Running Test
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > finaloutput.txt 




