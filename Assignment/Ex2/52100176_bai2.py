from itertools import *

with open('input.txt' ,encoding="utf-8") as f:
    data = f.read().splitlines()

attributes = set(data[0].split(','))

def dict_of_data(data):
  temp = {}
  for i in data[1].split(','):
      index = i.split('->')
      temp[index[0]] = index[1]
  return temp

temp = dict_of_data(data)
 
list_of_att = []

def add(attributes, list_of_att):
  for i in range(len(attributes)):
    list_of_att = list_of_att + list( ' '.join(k) for k in combinations(attributes, i+1) )
  return list_of_att

list_of_att_2 = add(attributes, list_of_att)

def keys(att_keys, dict_funct):
  for f in dict_funct:
    if( set(f.split()).issubset(att_keys)):
      att_keys = att_keys.union(set(dict_funct[f].split()))
      if len(dict_funct) > 0:
        dict_funct.pop(f)
      return keys(att_keys , dict_funct)
  return att_keys

def list_of_keys(temp, list_of_att_2):
  list_of_keys = []
  for Attributes in list_of_att_2:
      att_keys = keys(set(Attributes.split()), temp.copy())
      if att_keys == attributes:
        list_of_keys.append(Attributes)
  return list_of_keys

list_of_keys = list_of_keys(temp, list_of_att_2)
  
def remove(list_of_keys):
  for i in list_of_keys:
    temp = set(i)
    for j in list_of_keys:
      temp_2 = set(j)
      if temp_2 > temp:
        list_of_keys.remove(j)
  return list_of_keys

while(set(list_of_keys) != set(remove(list_of_keys))):
  list_of_keys = remove(list_of_keys)

with open('output.txt', 'w', encoding="utf-8") as w:
    for f in list_of_keys:
        w.write( str(f) +'\n')