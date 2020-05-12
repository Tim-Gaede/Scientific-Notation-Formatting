using Formatting

#-------------------------------------------------------------------------------
function superscript(n::Int)
    if n == 0;    return "⁰";    end

    res = ""
    n < 0    ?    rem = -n    :    rem = n

    sups = ["¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹", "⁰"]

    while rem > 0
        d = rem % 10 # digit
        rem ÷= 10

        d == 0    ?    res *= string(sups[10])    :    res *= string(sups[d])
    end
    if n < 0;    res *= "⁻";   end

    reverse(res) # returned
end
#-------------------------------------------------------------------------------



#-------------------------------------------------------------------------------
function sci(n, sigFigs)
    pwr = convert(Int, floor(log10(abs(n))))

    mant = format(n / 10.0^pwr, precision=sigFigs-1)

    if (n < 0.0  &&  length(mant) > sigFigs + 2)  ||
       (n > 0.0  &&  length(mant) > sigFigs + 1)
        pwr += 1
        mant = format(n / 10.0^pwr, precision=sigFigs-1)
    end
    mant * " × 10" * superscript(pwr)
end
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
function sciVert(a, sigFigs)
    neg_fnd = false
    i = 1
    while !neg_fnd  &&  i ≤ length(a)
        if a[i] < 0;    neg_fnd = true;    end

        i += 1
    end

    res = ""

    for aᵢ in a
        pwr = convert(Int, floor(log10(abs(aᵢ))))

        mant = format(aᵢ / 10.0^pwr, precision=sigFigs-1)

        if (aᵢ < 0.0  &&  length(mant) > sigFigs + 2)  ||
           (aᵢ > 0.0  &&  length(mant) > sigFigs + 1)
            pwr += 1
            mant = format(aᵢ / 10.0^pwr, precision=sigFigs-1)
        end

        if aᵢ ≥ 0  &&  neg_fnd;    res *= " ";    end

        res *= mant * " × 10" * superscript(pwr) * "\n"

    end

    res # returned
end
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
function printSciVert(a, sigFigs)
    neg_fnd = false
    i = 1
    while !neg_fnd  &&  i ≤ length(a)
        if a[i] < 0;    neg_fnd = true;    end

        i += 1
    end



    for aᵢ in a
        pwr = convert(Int, floor(log10(abs(aᵢ))))

        mant = format(aᵢ / 10.0^pwr, precision=sigFigs-1)

        if (aᵢ < 0.0  &&  length(mant) > sigFigs + 2)  ||
           (aᵢ > 0.0  &&  length(mant) > sigFigs + 1)
            pwr += 1
            mant = format(aᵢ / 10.0^pwr, precision=sigFigs-1)
        end

        res = ""
        if aᵢ ≥ 0  &&  neg_fnd;    res *= " ";    end

        res *= mant * " × 10" * superscript(pwr)
        println(res)

    end

end
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
function main()
    println("-"^displaysize(stdout)[2], "\n"^3)

    N = 20
    pwr_lim = 7
    decimals = 5


    arr = [10^(2pwr_lim*rand() - pwr_lim)    for i = 1 : N]

    for i = 1 : length(arr)
        if rand(Bool);    arr[i] *= -1;    end
    end

    print(sciVert(arr, 3))
    println("\n")
    printSciVert(arr, 3)
    println("\n"^5)

    arr = [-1.00001 * 10^5, -9.99999*10^4,
            1.00001 * 10^5,  9.99999*10^4,
           -1.00001 * 10^-5, -9.99999*10^-6,
            1.00001 * 10^-5,  9.99999*10^-6]

    print(sciVert(arr, 5))
    println("\n")
    printSciVert(arr, 5)


end
main()
#-------------------------------------------------------------------------------
