CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission

if [[ -f "ListExamples.java" ]]
then
    echo 'File present'
    cd ..
    cp student-submission/ListExamples.java ./
else 
    echo "File not present"
    exit 1;
fi 


javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java 2>compile-error.txt

if [[ -e "compile-error.txt" ]]
then
    echo "Compile error, check compile-error.txt"
    exit 1
else
    echo "compiled"
fi

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples.java

