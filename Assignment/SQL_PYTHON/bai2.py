def convertStringtolist(a):
  for i in range(0,len(a)):
    a[i]=list(a[i])
  return a
def convertListtoString(a):
  b=''
  c=[]
  for i in range(0,len(a)):
    for j in range(0,len(a[i])):
      b=b+a[i][j]
    c.append(b)
    b=''
  return c
def tao_list(len,n):
  a=[]
  for i in range(0,int((len/(2**n))/2)):
    for j in range(0,2**n):
      a.append(0)
    for z in range(0,2**n):
      a.append(1)
  return a
#Tìm bao đống
def baodong(N,le,ri):
    le2=le.copy()
    ri2=ri.copy()
    res=''
    N=set(N)
    i=0
    while(i<len(le2)):
        a=set(N)&set(le2[i])
        if(a==set(le2[i])):
            N=list(N)+list(ri2[i])
            le2.pop(i)
            ri2.pop(i)
            i=0
            continue
        i=i+1
    res=list(set(N))
    return res
#print(baodong(['B', 'G', 'A'],[['B'], ['C', 'D'], ['A', 'C'], ['B', 'C'], ['C']],[['E', 'C'], ['A', 'B'], ['B', 'D'], ['A', 'E'], ['A', 'D']]))
f = open('input.txt', 'r')
qa=f.readlines()
qa0=qa[0]
qa1=qa[1]
qa2=qa[2]
F0=list(qa0.strip().split(','))
F1=list(qa1.strip().split(';'))
F2=list(qa2.strip().split(','))
le=[] 
ri=[] 
dict={}
for i in F1:
    le.append(i.split('->')[0])
    ri.append(i.split('->')[1])
# PHÂN RÃ VẾ PHẢI
ri1=''
for i in range(0,len(ri)):
    ri1=ri1+ri[i]
# TÌM NGUỒN(N)
N=sorted(list(set(F0)-set(ri1)))
#Bao đống nguồn
baodongN=baodong(N,convertListtoString(le),convertListtoString(ri))
if(sorted(baodongN)==sorted(F0)):
  wf = open('ouput.txt', 'w')
  wf.writelines(str(baodongN))
else:
  # PHÂN RÃ VẾ TRÁI
  le1=''
  for i in range(0,len(le)):
      le1=le1+le[i]
  # TÌM ĐÍCH(D)
  D=sorted(list(set(F0)-set(le1)-set(N)))
  #TÌM TRUNG GIAN(L)
  L=sorted(list(set(F0)-set(D)-set(N)))

  K=[]
  for i in range(0,len(L)):
    K.append(tao_list(2**len(L),i))
  # print(K)
  temp=N
  N_chuabaodong=[]
  for i in range(0,len(K[0])):
      for j in range(0,len(K)):
          if(K[j][i]==1):
              temp=temp+list(L[j])
      N_chuabaodong.append(temp)
      temp=N
  t_1=convertStringtolist(le)
  t_2=convertStringtolist(ri)
  N_dabaodong=[]
  for i in range(0,len(N_chuabaodong)):
    N_dabaodong.append(baodong(N_chuabaodong[i],t_1,t_2))
  khoa=[]
  for i in range(0,len(N_dabaodong)):
    if(sorted(F0)==sorted(N_dabaodong[i])):
      khoa.append(N_chuabaodong[i])
  wf = open('ouput.txt', 'w')
  wf.writelines(sorted(convertListtoString(baodong(F2,t_1,t_2))))
  wf.writelines('\n')
  khoa=convertListtoString(khoa)
  wf.writelines(str(khoa))
  f.close()
  wf.close()