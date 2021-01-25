#!/bin/bash

path=~/projects_19/ft_printf
includes=$path/includes
tests_file=mandatory_conversions
gcc_flags="-Wno-format"
#tests_file=bonus_conversions

function test_compare
{
format=$1
counter=$2

# compile main with libc printf and store output in a file
func=printf
gcc $gcc_flags -I $includes -D FORMAT="$format" -D FUNC=$func -o test_libc main_test.c -lm
./test_libc > output_libc 2>&1
#echo "" >> output_libc

# compile main with ft_printf and store output in a file
func=ft_printf
gcc $gcc_flags -I $includes -D FORMAT="$format" -D FUNC=$func -o test_ft main_test.c -L $path -lftprintf -lm
./test_ft > output_ft 2>&1
#echo "" >> output_ft

# store outputs in all_outputs file
echo "test $counter:" >> all_outputs
echo "format, args: $format" >> all_outputs
echo "libc printf: " >> all_outputs
cat output_libc >> all_outputs
echo "--- " >> all_outputs
echo "ft_printf: " >> all_outputs
cat output_ft >> all_outputs
echo "----------------------------- " >> all_outputs

# compare outputs with diff and store in diff_log
echo "test $counter:" >> diff_log
diff output_libc output_ft >> diff_log

comp_value=$?

# if different (test fail), display outputs
if [ $comp_value -eq 1 ]
then
	echo "----------------------------- "
	echo "test $counter: FAIL"
	echo "format, args: $format"
	echo "libc printf: "
	cat output_libc
	echo "--- "
	echo "ft_printf: "
	cat output_ft
	echo "----------------------------- "
else
	echo "test $counter: OK"
fi
}


# compile ft_printf library
make -C $path

# reset log files
rm -f diff_log
rm -f all_outputs

# echo "< libc printf" >> diff_log
# echo "---" >> diff_log
# echo "> ft_printf" >> diff_log
# echo "----------------" >> diff_log

# initialize test counter (1 because lines are counted from one in vscode and that's convenient)
let "counter = 1"

# call function in a loop to iterate over format strings - arguments
while read i
do
	test_compare "$i" $counter
	let "counter++"
done < ./$tests_file
