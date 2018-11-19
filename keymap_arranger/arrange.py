import sys

with open(sys.argv[1],'r') as f:
    keymap_string=f.read()
keymap_lists=str.split(keymap_string,'\n')
lists=[0]*(keymap_lists.__len__())
keymap_num=0
for i in range(keymap_lists.__len__()):
    lists[keymap_num]=str.split(keymap_lists[i],'  ')
    if lists[keymap_num].__len__()>=2:
        keymap_num+=1
        
def true_for_all(f):
    for i in range(keymap_num):
        if not f(lists[i]):
            return False
    return True

def delete_zero_string(l):
    for i in range(l.count('')):
        l.remove('')
    return True

true_for_all(delete_zero_string)

while not true_for_all(lambda l:l.__len__()<=2):
    def remove0(l):
        if l.__len__()==2:
            return True
        l[0]=l[1]
        l[1]=l[2]
        l.pop()
        return True
    def remove2(l):
        if l.__len__()==2:
            return True
        l.pop()
        return True

    if true_for_all(lambda l:l[0].__len__()==1|l.__len__()==2):
        true_for_all(remove0)
    elif true_for_all(lambda l:True if l.__len__()==2 else l[2].__len__()<=2):
        true_for_all(remove2)
    else:
        break

SPACE_LEFT=4*3
for i in range(keymap_num):
    index=0
    strings=lists[i]
    print(strings[0],end='')
    for k in range(SPACE_LEFT-strings[0].__len__()):
       print(' ',end='') 
       
    for j in range(1,strings.__len__()):
        print(strings[j],end='')

    print()

    
