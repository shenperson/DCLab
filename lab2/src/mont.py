def mont(N, a, b):
    m = 0
    # print("mont")
    for i in range(256):
        # print('i=', i, ", m=", hex(m))
        if (a >> i) % 2 == 1:
            m = m + b
        if m % 2 == 1:
            m = m + N

        m = m // 2
    if m >= N:
        m = m - N
    return m


# n = "CA3586E7EA485F3B0A222A4C79F7DD12E85388ECCDEE4035940D774C029CF831"
# N = int(n, 16)

# # a = 1

# b = "b6ace0b14720169839b15fd13326cf1a1829beafc37bb937bec8802fbcf46bd9"
# # b = "622835729cf894964298124e9f9978b60d7d2db3a720389f56d321260ab8b552"
# b = int(b, 16)

# # a = "c6b662ecb173c53cc7bb4212057f9c0ba283e000b98c9dcf5feaee7d6c933dfb"

# a = "9d29a982563bf87a5814dfc70059a3772cf98a11099f093a2e95d5a874836dd8"

# # a = "622835729cf894964298124e9f9978b60d7d2db3a720389f56d321260ab8b552"
# a = int(a, 16)

# # zzz = 0x7da4d0d09c6254c315b719b9e4e24cb6f7890fe350bf2e429fbb83ef83fca96d
# # print(hex((zzz+N)//2))

# m = mont(N, a, b)
# # print(hex(m))
