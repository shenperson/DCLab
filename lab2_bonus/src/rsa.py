from mod_product import *
from mont import *

def RSA256MONT(N,y,d):
    t = MODULOPRODUCT(N,2**512,y,512)
    m = 1
    for i in range(512):
        if (d >> i) % 2 == 1:
            # print("mont")
            m = mont(N,m,t)
        t = mont(N,t,t)
        # print(i,hex(m))
        # print(i,hex(t))
    return m

n = "CA3586E7EA485F3B0A222A4C79F7DD12E85388ECCDEE4035940D774C029CF831CA3586E7EA485F3B0A222A4C79F7DD12E85388ECCDEE4035940D774C029CF831"
N = int(n, 16)

d = "b6ace0b14720169839b15fd13326cf1a1829beafc37bb937bec8802fbcf46bd9b6ace0b14720169839b15fd13326cf1a1829beafc37bb937bec8802fbcf46bd9"
# d = "622835729cf894964298124e9f9978b60d7d2db3a720389f56d321260ab8b552"

D = int(d, 16)

y = "9d29a982563bf87a5814dfc70059a3772cf98a11099f093a2e95d5a874836dd89d29a982563bf87a5814dfc70059a3772cf98a11099f093a2e95d5a874836dd8"
# y = "c6b662ecb173c53cc7bb4212057f9c0ba283e000b98c9dcf5feaee7d6c933dfb"

# y = "622835729cf894964298124e9f9978b60d7d2db3a720389f56d321260ab8b552"
Y = int(y, 16)

m = RSA256MONT(N,Y,D)
print(hex(m))

with open('tb_verilog/wrapper_input.txt','r') as f:
    s = ''.join(f.read().split('\n'))
    n_256 = s[:64]
    n_512 = n_256 * 2
    d_256 = s[64:128]
    d_512 = d_256 * 2
    y_256, y_512 = [], []
    for i in range((len(s)-128)//64):
        y_256.append(s[(i+2)*64:(i+3)*64])
        y_512.append(s[(i+2)*64:(i+3)*64]*2)

with open('tb_verilog/wrapper_input512.txt','w') as f:
    for i,word in enumerate(n_512):
        if i%2==0 and i!=0:
            f.write('\n')
        f.write(word.lower())
    f.write('\n')
    for i,word in enumerate(d_512):
        if i%2==0 and i!=0:
            f.write('\n')
        f.write(word.lower())
    f.write('\n')
    for y in y_512:
        for i,word in enumerate(y):
            if i%2==0 and i!=0:
                f.write('\n')
            f.write(word.lower())
        f.write('\n')

with open('tb_verilog/wrapper_output512.txt','w') as f:
    N = int(n_512, 16)
    D = int(d_512, 16)
    for y in y_512:
        Y = int(y, 16)
        m = RSA256MONT(N,Y,D)
        hex_m = str(hex(m))[2:]
        hex_m = ((128-len(hex_m))*'0' + hex_m)[2:]
        # print(len(hex_m),hex_m)

        for i,word in enumerate(hex_m):
            if i%2==0 and i!=0:
                f.write('\n')
            f.write(word.lower())
        f.write('\n')
