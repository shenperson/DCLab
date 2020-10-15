def MODULOPRODUCT(N, a, b, k):
    t = b
    m = 0
    # print("product")
    for i in range(k+1):
        # print('i=', i, ", t=", hex(t))
        if (a >> i) % 2 == 1:
            if m+t >= N:
                m = m+t-N
            else:
                m = m+t
        if t+t >= N:
            t = t+t-N
        else:
            t = t+t
    return m


# a = 1 << 256
# y = "c6b662ecb173c53cc7bb4212057f9c0ba283e000b98c9dcf5feaee7d6c933dfb"
# b = int(y, 16)

# n = "CA3586E7EA485F3B0A222A4C79F7DD12E85388ECCDEE4035940D774C029CF831"
# N = int(n, 16)
# k = 256
# m = MODULOPRODUCT(N, a, b, k)
# print(m)
# print(hex(m))
