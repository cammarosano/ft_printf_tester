#include <stdlib.h>
#include <time.h>
#include <unistd.h>

void *fake_malloc(size_t size)
{
	int r;
	static int x = 0;
	int fail_freq = 12; // You can change this numbert to make malloc fail more or less often

	srand(time(NULL) + x++);
	r = rand() % fail_freq; 
	if (r)
	{
		write(1, "\033[1;32m_malloc()_\033[0m", 21);  // comment out this line if you don't want this message displayed
		return (malloc(size));
	}
	write(1, "\033[1;31m**malloc() error**\033[0m", 29);	 // comment out this line if you don't want this message displayed
	return (NULL);
}
