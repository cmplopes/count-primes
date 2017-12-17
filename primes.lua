function isPrime( n )
    if n <= 1 then return false end
    if n <= 3 then return true  end
    if ( n % 2 == 0 or n % 3 == 0 ) then return false end
	c = 5
	while (c*c<= n) do
		if (  n % c == 0  or  n%(c+2) == 0  ) then
			return false
		end
		c = c + 6
    end
    return true
end

LIMIT=20000000
count = 0

print('Lua');
starttime=os.time();

for i=1,LIMIT do
	if isPrime(i) then count = count + 1 end
end

print(os.time()-starttime.."sec");

io.write(count)
