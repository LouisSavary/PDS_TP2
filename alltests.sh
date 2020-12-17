#!/bin/bash
# arg1 = le niveau de test
if [ $# -lt 1 ]
then
	echo "niveau de test requis : alltests.sh (nv_test)"
	exit
fi

export DOC="~/eclipse-workspace/PDS-TP2-java"
tests_dir="tests/testlevel$1"
result_file="res_tests$1"
echo "" > $result_file
#cd $DOC

./gradlew build
echo $PWD
for file in $(ls $tests_dir | grep ".vsl" )
do	
	echo $file
	file_name=$(echo $file |cut -d'.' -f1)
	
	./compile "$tests_dir/$file"
	cat "$tests_dir/$file" >> $result_file
	sudo $tests_dir/$file_name 
	echo $? >> $result_file
	echo "" >> $result_file
	
	echo ""
	echo "________________________________________________"
	echo ""
	
	rm "$tests_dir/$file_name"
	rm "$tests_dir/$file_name.ll"
done
