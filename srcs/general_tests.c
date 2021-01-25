#include <stdio.h>
#include "ft_printf.h"

int		main(void)
{
	int		ret_ft;
	int		ret_libc;
	
	ret_ft = ft_printf("%d\n", -1);
	ret_libc =  printf("%d\n", -1);

	printf("\nft_printf return value: %d\n", ret_ft));
	printf("\nlibc printf return value: %d\n", ret_libc));
	

}
