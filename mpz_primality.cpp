// -----------------------------------------------------------------------
// Simple primality check based on mpz
// -----------------------------------------------------------------------

#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include "mpz_primality.h"

bool mpz_mpz_primality(mpz_t n, bool verbose)
{
    if (verbose)
    {
        gmp_printf("Testing a %lu digits number\n", mpz_sizeinbase(n, 10));
    }

    bool b = mpz_probab_prime_p(n,0);
    if (b == false)
    {
        printf("Number is composite\n");
    }
    else
    {
        printf("Number passed all tests and is unlikely a composite one\n");
    }

    return b;
}

void mpz_primality_self_test(void)
{
}

