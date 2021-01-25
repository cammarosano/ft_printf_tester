#include <stdlib.h>
#include <time.h>
#include <unistd.h>

void *fake_malloc(size_t size)
{
	int r;
	static int x = 0;
	int fail_freq = 10; // malloc will fail in about 1 in 10 times. You can change this number (10 to something else)

	srand(time(NULL) + x++);
	r = rand() % fail_freq; 
	if (r)
	{
		write(1, "_malloc()_", 10);  // comment out this line if you don't want this message displayed
		return (malloc(size));
	}
	write(1, "**malloc() error**", 18);	 // comment out this line if you don't want this message displayed
	return (NULL);
}

/*
** Insert the lines bellow (uncommented) in the .h file 
** and compile the tester program with this source file.
*/

// void *fake_malloc(size_t size);
// # define malloc(x) fake_malloc(x)
