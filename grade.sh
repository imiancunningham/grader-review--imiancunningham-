CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm compile-error.txt

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


javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" *.java 2> compile-error.txt

if [[ $? -ne 0 ]]
then
    echo "Compile error, check compile-error.txt"
    exit 1
else
    echo "compiled"
fi

java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar"  org.junit.runner.JUnitCore TestListExamples > junit-errors.txt

if grep -q "FAILURES!!!" junit-errors.txt
then
    echo "You had at least one failing test, you fail"
    echo `grep -c "results.txt" compile-error.txt`
    ERROR_NUMBERS = ${"error":12:2}
    echo ERROR_NUMBERS

fi