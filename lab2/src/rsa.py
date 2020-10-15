from mod_product import *
from mont import *

def RSA256MONT(N,y,d):
    t = MODULOPRODUCT(N,2**256,y,256)
    m = 1
    for i in range(256):
        if (d >> i) % 2 == 1:
            # print("mont")
            m = mont(N,m,t)
        t = mont(N,t,t)
        print(i,hex(m))
        print(i,hex(t))
    return m

n = "CA3586E7EA485F3B0A222A4C79F7DD12E85388ECCDEE4035940D774C029CF831"
N = int(n, 16)

d = "b6ace0b14720169839b15fd13326cf1a1829beafc37bb937bec8802fbcf46bd9"
# d = "622835729cf894964298124e9f9978b60d7d2db3a720389f56d321260ab8b552"

d = int(d, 16)

y = "9d29a982563bf87a5814dfc70059a3772cf98a11099f093a2e95d5a874836dd8"
# y = "c6b662ecb173c53cc7bb4212057f9c0ba283e000b98c9dcf5feaee7d6c933dfb"

# y = "622835729cf894964298124e9f9978b60d7d2db3a720389f56d321260ab8b552"
y = int(y, 16)

m = RSA256MONT(N,y,d)
print(hex(m))