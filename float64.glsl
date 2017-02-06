/* Compile with:
 *
 * glsl_compiler --version 130 --dump-builder float64.glsl > builtin_float64.h
 *
 */
#version 130

/* Returns the fraction bits of the double-precision floating-point value `a'.*/
uvec2
extractFloat64Frac( uvec2 a )
{
    return uvec2( a.x & 0x000FFFFFu, a.y );
}

/* Returns the exponent bits of the double-precision floating-point value `a'.*/
uint
extractFloat64Exp( uvec2 a )
{
    return (a.x>>20) & 0x7FFu;
}

/* Returns the sign bit of the double-precision floating-point value `a'.*/
uint
extractFloat64Sign( uvec2 a )
{
    return (a.x>>31);
}

/* Returns the fraction bits of the single-precision floating-point value `a'.*/
uint
extractFloat32Frac( uint a )
{
    return a & 0x007FFFFFu;
}

/* Returns the exponent bits of the single-precision floating-point value `a'.*/
uint
extractFloat32Exp( uint a )
{
    return (a>>23) & 0xFFu;
}

/* Returns the sign bit of the single-precision floating-point value `a'.*/
uint
extractFloat32Sign( uint a )
{
    return a>>31;
}

/* Packs the sign `zSign', the exponent `zExp', and the significand formed by
 * the concatenation of `zFrac0' and `zFrac1' into a double-precision floating-
 * point value, returning the result.  After being shifted into the proper
 * positions, the three fields `zSign', `zExp', and `zFrac0' are simply added
 * together to form the most significant 32 bits of the result.  This means
 * that any integer portion of `zFrac0' will be added into the exponent.  Since
 * a properly normalized significand will have an integer portion equal to 1,
 * the `zExp' input should be 1 less than the desired result exponent whenever
 * `zFrac0' and `zFrac1' concatenated form a complete, normalized significand.
 */
uvec2
packFloat64( uint zSign, uint zExp, uint zFrac0, uint zFrac1 )
{
    uvec2 z;

    z.x = ( zSign<<31 ) + ( zExp<<20 ) + zFrac0;
    z.y = zFrac1;
    return z;
}

/* Returns the number of leading 0 bits before the most-significant 1 bit of
 * `a'.  If `a' is zero, 32 is returned.
 */
uint
countLeadingZeros32( uint a )
{
   const uint countLeadingZerosHigh[] = uint[](
        8u, 7u, 6u, 6u, 5u, 5u, 5u, 5u, 4u, 4u, 4u, 4u, 4u, 4u, 4u, 4u,
        3u, 3u, 3u, 3u, 3u, 3u, 3u, 3u, 3u, 3u, 3u, 3u, 3u, 3u, 3u, 3u,
        2u, 2u, 2u, 2u, 2u, 2u, 2u, 2u, 2u, 2u, 2u, 2u, 2u, 2u, 2u, 2u,
        2u, 2u, 2u, 2u, 2u, 2u, 2u, 2u, 2u, 2u, 2u, 2u, 2u, 2u, 2u, 2u,
        1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u,
        1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u,
        1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u,
        1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u, 1u,
        0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u,
        0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u,
        0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u,
        0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u,
        0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u,
        0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u,
        0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u,
        0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u
    );
    uint shiftCount;

    shiftCount = 0u;
    if ( ( a < 0x10000u ) == true ) {
        shiftCount += 16u;
        a <<= 16;
    }
    if ( ( a < 0x1000000u ) == true ) {
        shiftCount += 8u;
        a <<= 8;
    }
    shiftCount += countLeadingZerosHigh[ a>>24 ];
    return shiftCount;
}

/* Normalizes the subnormal single-precision floating-point value represented
 * by the denormalized significand `aFrac'.  The normalized exponent and
 * significand are stored at the locations pointed to by `zExpPtr' and
 * `zFracPtr', respectively.
 */
void
normalizeFloat32Subnormal( uint aFrac,
                           inout uint zExpPtr,
                           inout uint zFracPtr )
{
    uint shiftCount;

    shiftCount = countLeadingZeros32( aFrac ) - 8u;
    zFracPtr = aFrac<<shiftCount;
    zExpPtr = 1u - shiftCount;
}

/* Absolute value of a Float64 :
 * Clear the sign bit
 */
uvec2
abs_fp64( uvec2 a )
{
    a.x &= 0x7FFFFFFFu;
    return a;
}

/* Negate value of a Float64 :
 * Toggle the sign bit
 */
uvec2
neg_fp64( uvec2 a )
{
    a.x ^= (1u<<31);
    return a;
}

/* Returns true if the double-precision floating-point value `a' is equal to the
 * corresponding value `b', and false otherwise.  The comparison is performed
 * according to the IEEE Standard for Floating-Point Arithmetic.
 */
bool
eq_fp64( uvec2 a, uvec2 b )
{
    uvec2 aFrac;
    uvec2 bFrac;
    bool isaNaN;
    bool isbNaN;

    aFrac = extractFloat64Frac( a );
    bFrac = extractFloat64Frac( b );
    isaNaN = ( extractFloat64Exp( a ) == 0x7FFu ) &&
        ( ( aFrac.x | aFrac.y ) != 0u );
    isbNaN = ( extractFloat64Exp( b ) == 0x7FFu ) &&
       ( ( bFrac.x | bFrac.y ) != 0u );

    if ( isaNaN || isbNaN ) {
        return false;
    }
    return ( a.y == b.y ) &&
        ( ( a.x == b.x ) ||
            ( ( a.y == 0u ) && ( ( ( a.x | b.x )<<1) == 0u ) ) );
}

/* Returns true if the 64-bit value formed by concatenating `a0' and `a1' is less
 * than or equal to the 64-bit value formed by concatenating `b0' and `b1'.
 * Otherwise, returns false.
 */
bool
le64( uint a0, uint a1, uint b0, uint b1 )
{
    return ( a0 < b0 ) || ( ( a0 == b0 ) && ( a1 <= b1 ) );
}

/* Returns true if the double-precision floating-point value `a' is less than or
 * equal to the corresponding value `b', and false otherwise.  The comparison is
 * performed according to the IEEE Standard for Floating-Point Arithmetic.
 */
bool
le_fp64( uvec2 a, uvec2 b )
{
    uint aSign;
    uint bSign;
    uvec2 aFrac;
    uvec2 bFrac;
    bool isaNaN;
    bool isbNaN;

    aFrac = extractFloat64Frac( a );
    bFrac = extractFloat64Frac( b );
    isaNaN = ( extractFloat64Exp( a ) == 0x7FFu ) &&
        ( ( aFrac.x | aFrac.y ) != 0u );
    isbNaN = ( extractFloat64Exp( b ) == 0x7FFu ) &&
       ( ( bFrac.x | bFrac.y ) != 0u );

    if ( isaNaN || isbNaN ) {
        return false;
    }

    aSign = extractFloat64Sign( a );
    bSign = extractFloat64Sign( b );
    if ( aSign != bSign ) {
        return ( aSign != 0u ) ||
            ( ( ( ( ( a.x | b.x )<<1 ) ) | a.y | b.y ) == 0u );
    }
    return ( aSign != 0u ) ? le64( b.x, b.y, a.x, a.y )
        : le64( a.x, a.y, b.x, b.y );
}

/* Returns true if the 64-bit value formed by concatenating `a0' and `a1' is less
 * than the 64-bit value formed by concatenating `b0' and `b1'.  Otherwise,
 * returns false.
 */
bool
lt64( uint a0, uint a1, uint b0, uint b1 )
{
    return ( a0 < b0 ) || ( ( a0 == b0 ) && ( a1 < b1 ) );
}

/* Returns true if the double-precision floating-point value `a' is less than
 * the corresponding value `b', and false otherwise.  The comparison is performed
 * according to the IEEE Standard for Floating-Point Arithmetic.
 */
bool
lt_fp64( uvec2 a, uvec2 b )
{
    uint aSign;
    uint bSign;
    uvec2 aFrac;
    uvec2 bFrac;
    bool isaNaN;
    bool isbNaN;

    aFrac = extractFloat64Frac( a );
    bFrac = extractFloat64Frac( b );
    isaNaN = ( extractFloat64Exp( a ) == 0x7FFu ) &&
        ( ( aFrac.x | aFrac.y ) != 0u );
    isbNaN = ( extractFloat64Exp( b ) == 0x7FFu ) &&
       ( ( bFrac.x | bFrac.y ) != 0u );

    if ( isaNaN || isbNaN ) {
        return false;
    }

    aSign = extractFloat64Sign( a );
    bSign = extractFloat64Sign( b );
    if( aSign != bSign ) {
        return ( aSign != 0u ) &&
            ( ( ( ( ( a.x | b.x )<<1 ) ) | a.y | b.y ) != 0u );
    }
    return ( aSign != 0u ) ? lt64( b.x, b.y, a.x, a.y )
        : lt64( a.x, a.y, b.x, b.y );
}

/* Returns the result of converting the single-precision floating-point value
 * `a' to the double-precision floating-point format.
 */
uvec2
fp32_to_fp64( uint a )
{
    uint aFrac;
    uint aExp;
    uint aSign;

    aFrac = extractFloat32Frac( a );
    aExp = extractFloat32Exp( a );
    aSign = extractFloat32Sign( a );

    if ( aExp == 0xFFu ) {
        if ( aFrac != 0u ) {
            /* NaN */
            return uvec2(
                ( ( aSign<<31 ) | 0x7FF00000u | ( aFrac>>3 ) ),
                ( aFrac<<29 )
            );
        }
        /* Inf */
        return packFloat64( aSign, 0x7FFu, 0u, 0u );
    }

    if ( aExp == 0u ) {
        if ( aFrac != 0u ) {
            /* Denormals */
            normalizeFloat32Subnormal( aFrac, aExp, aFrac );
            --aExp;
        }
    /* Zero */
    return packFloat64( aSign, 0u, 0u, 0u );
    }

    return packFloat64( aSign, aExp + 0x380u, aFrac>>3, aFrac<<29 );
}
