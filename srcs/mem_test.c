#include "ft_printf.h"

int	main(void)
{
	int	x;

	ft_printf("Hello %c shall %.24s we %p test %-5d for %05i memory %u leaks %*x ? %.*X %%\n",
				'!', "Valgrind be by your side...", &x, -798, 321, 3000000000u, 3, 15, 3, 10);
}
