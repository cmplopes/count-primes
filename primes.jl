# This code and all turorial code can be found on https://github.com/forio/julia-tutorials

function is_prime(num)
    if (num <= 1)
        return false
    elseif (num <= 3)
        return true
    elseif (((num % 2) == 0) || ((num % 3) == 0))
        return false
    end
    c = 5
    while c*c <= num 
        if (((num % c) == 0) || ((num % (c+2)) == 0))
            return false
        end
        c += 6
    end
    return true
end

function getprimecount(min, max)
    cont = 0
    for i = min: max
        if is_prime(i)
            cont += 1
        end 
    end
    return cont
end

println("Julia")
@time cont = getprimecount(0, 20000000)
println(cont)
