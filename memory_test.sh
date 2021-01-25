path=../ft_printf
includes_dir=includes/

#copy project repo as mem_test
cp -r $path mem_test

#inject evil code in the header file (fake malloc prototype and define)
echo "/* The code below was added by memory_test.sh */" >> mem_test/$includes_dir/ft_printf.h
echo "void *fake_malloc(size_t size);" >> mem_test/$includes_dir/ft_printf.h
echo "#define malloc(x) fake_malloc(x)" >> mem_test/$includes_dir/ft_printf.h

#compile library
make -C mem_test

#compile test main (mem_tester) with library
gcc -I ./mem_test/$includes_dir srcs/mem_test.c srcs/fake_malloc.c -L ./mem_test -lftprintf -o mem_tester

#clean up the mess
rm -rf mem_test

#run mem_tester with valgrind n times
let "i=0"
let "n=10"
while [ $i -lt $n ]
do
	echo "Test $i:"
	valgrind ./mem_tester
	echo ""
	let "i++"
done

echo "To run more tests:"
echo "$ valgrind ./mem_tester"

