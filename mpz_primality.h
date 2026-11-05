#pragma once

// -----------------------------------------------------------------------
// Cubic primality test
//
// mpz_mpz_primality():
//    true: composite for sure
//    false: might be prime
//
// mpz_primality_self_test()
//    simplified unit tests to detect a possible compiler/platform issue.
//    assert when fail (this should not happen).
// -----------------------------------------------------------------------

#include "gmp.h"
#include <stdbool.h>

bool mpz_mpz_primality(mpz_t v, bool verbose = false);
void mpz_primality_self_test(void);
