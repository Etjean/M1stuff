#6.6.7
#for i in range(1000):
#    istr = str(i)
#    isp = list(istr)
#    
#    isum = 0
#    for chiffre in isp:
#        isum += int(chiffre)
#    
#    ichid = False
#    if len(isp) >= 3:
#        if isp[0] == isp[1] or isp[0] == isp[2] or isp[1] == isp[2]:
#            ichid = True
#
#    if i<200 and isum==5 and (i//2)*2==i and ichid:
#        print(i)


#6.6.10
#methode1
count = 0
N = 100
for n in range(2, N+1):
    nbrestenul = 0
    for div in range(1, nb+1):
        if n%div == 0:
            nbrestenul += 1
    if nbrestenul == 2: 
        print(n)
        count += 1
print('il y a '+str(count)+' nombres premiers inferieurs a '+str(N)+'\n')

#methode2
N = 1000
premiers = [2]
print(2)
for n in range(2, N+1):
    k = 1
    for prem in premiers:
        k = k*(n%prem)
    if k != 0:
        premiers.append(n)
        print(n)







































