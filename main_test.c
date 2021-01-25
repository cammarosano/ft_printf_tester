#include "ft_printf.h"
#include <stdio.h>
#include <locale.h>
#include <wchar.h>
#include <math.h>

int	main(void)
{
	int	ret;
	char	str[5] = "12345";
	wchar_t	wstr[7] = L"עขकऀӨעข";
	wstr[6] = 0x0990;
	int n = 0;

	//setlocale(LC_ALL, "fr_BE.utf8");
	ret = FUNC(FORMAT);
	printf("\nreturn value: %d\n", ret);
	return (0);
}
