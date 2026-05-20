def FA_sum(a, b, c):
    total = a + b + c
    sum = total & 1
    return sum


def FA_carry(a, b, c):
    total = a + b + c
    carry = (total >> 1) & 1
    return carry


def HA_carry(a, b):
    return a & b


def NOT(a):
    return a ^ 1


def LUT3_1(I0, I1, I2):
    # put your LUT logic here
    # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    # (9 ： 4,1]
    # --- Third LUT
    O = FA_carry(I0, I1, I2)
    return O


def LUT5_1(I0, I1, I2, I3, I4):
    # put your LUT logic here
    # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    # the modified Booth recoding logic
    # I0, I1, I2 are mapped to the split operand, from LSBs to MSBs
    # I3, I4 are mapped to the other operand; I4 - higher rank, I3 - lower rank
    # O = 0
    # match (I2, I1, I0):
    #     case (0, 0, 0):
    #         O = 0
    #     case (0, 0, 1):
    #         O = I4
    #     case (0, 1, 0):
    #         O = I4
    #     case (0, 1, 1):
    #         O = I3
    #     case (1, 0, 0):
    #         O = NOT(I3)
    #     case (1, 0, 1):
    #         O = NOT(I4)
    #     case (1, 1, 0):
    #         O = NOT(I4)
    #     case (1, 1, 1):
    #         O = 1
    # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    # the modified Booth recoding logic
    # I0, I1, I2 are mapped to the split operand, from LSBs to MSBs
    # I3, I4 are mapped to the other operand; I4 - lower rank, I3 - higher rank
    O = 0
    match (I2, I1, I0):
        case (0, 0, 0):
            O = 0
        case (0, 0, 1):
            O = I3
        case (0, 1, 0):
            O = I3
        case (0, 1, 1):
            O = I4
        case (1, 0, 0):
            O = NOT(I4)
        case (1, 0, 1):
            O = NOT(I3)
        case (1, 1, 0):
            O = NOT(I3)
        case (1, 1, 1):
            O = 1
    # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    # the modified Booth recoding logic -- for inverted sign bits
    # I0, I1, I2 are mapped to the split operand, from LSBs to MSBs
    # I4, I5 are mapped to the other operand
    # O = 0
    # match (I2, I1, I0):
    #     case (0, 0, 0):
    #         O = 1
    #     case (0, 0, 1):
    #         O = NOT(I4)
    #     case (0, 1, 0):
    #         O = NOT(I4)
    #     case (0, 1, 1):
    #         O = NOT(I3)
    #     case (1, 0, 0):
    #         O = I3
    #     case (1, 0, 1):
    #         O = I4
    #     case (1, 1, 0):
    #         O = I4
    #     case (1, 1, 1):
    #         O = 0
    return O



def LUT5_2(I0, I1, I2, I3, I4):
    # put your LUT logic here
    # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    # (1,5 : 3]
    # --- First LUT, EVEN
    O5 = FA_sum(FA_sum(I2, I1, I0), I3, I4)
    O6 = FA_carry(FA_sum(I2, I1, I0), I3, I4)
    # --- First LUT, ODD
    # O5 = FA_sum(FA_sum(I2, I1, I0), I3, I4)
    # O6 = FA_gen(FA_sum(I2, I1, I0), I3)
    # --- Second LUT, EVEN
    # O5 = FA_sum(FA_carry(I2, I1, I0), I3, I4)
    # O6 = FA_carry(FA_carry(I2, I1, I0), I3, I4)
    # --- Second LUT, ODD
    # O5 = FA_sum(FA_carry(I2, I1, I0), I3, I4)
    # O6 = FA_gen(FA_carry(I2, I1, I0), I3)
    # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    # (3 ： 2]
    # --- EVEN
    # O5 = FA_sum(I2, I3, I4)
    # O6 = FA_carry(I2, I3, I4)
    # --- ODD
    # O5 = FA_sum(I2, I3, I4)
    # O6 = FA_gen(I2, I3)
    # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    # (2,2,3 ： 4]
    # --- First LUT
    # O5 = FA_sum(I2, I3, I4)
    # O6 = FA_sum(I0, I1, FA_carry(I2, I3, I4))
    # --- Second LUT
    # O5 = FA_sum(I2, I3, FA_carry(I0, I1, XOR(XOR(I0, I1), I4)))
    # O6 = FA_carry(I2, I3, FA_carry(I0, I1, XOR(XOR(I0, I1), I4)))
    # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    # (9 ： 4,1]
    # --- First LUT
    # O5 = FA_carry(FA_sum(I0, I1, I2), I3, I4)
    # O6 = FA_sum(FA_sum(I0, I1, I2), I3, I4)
    # --- Second LUT
    # O5 = FA_sum(FA_sum(I0, I1, I2), I3, I4)
    # O6 = FA_carry(FA_sum(I0, I1, I2), I3, I4)
    # --- Third LUT: have to use LUT3_1 and constraints
    # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    # (3,9 ： 2,3,1]
    # --- First LUT
    # O5 = FA_carry(FA_sum(I0, I1, I2), I3, I4)
    # O6 = FA_sum(FA_sum(I0, I1, I2), I3, I4)
    # --- Second LUT
    # O5 = FA_sum(FA_sum(I0, I1, I2), I3, I4)
    # O6 = FA_carry(FA_sum(I0, I1, I2), I3, I4)
    # --- Third LUT
    # O5 = FA_carry(FA_carry(I0, I1, I2), I3, I4)
    # O6 = FA_sum(FA_carry(I0, I1, I2), I3, I4)
    # --- Fourth LUT
    # O5 = FA_sum(FA_carry(I0, I1, I2), I3, I4)
    # O6 = FA_carry(FA_carry(I0, I1, I2), I3, I4)
    # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    # first row of bit heap generation with radix-4 Booth Recoding
    # where b_{2*i-1} is always 1'b0
    # I0 => b_{2*i}, I1 => b_{2*i+1}, I2 => a_{2*i-1}, I3 => a_{2*i}, I4 => a_{2*i+1}
    # match (I1, I0):
    #     case (0, 0):
    #         O5 = 0
    #         O6 = 0
    #     case (0, 1):
    #         O5 = I3
    #         O6 = I4
    #     case (1, 0):
    #         O5 = NOT(I2)
    #         O6 = NOT(I3)
    #     case (1, 1):
    #         O5 = NOT(I3)
    #         O6 = NOT(I4)
    # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    # first row of bit heap generation with radix-4 Booth Recoding
    # where b_{2*i-1} is always 1'b0
    # I0 => b_{2*i}, I1 => b_{2*i+1}, I2 => a_{2*i-1}, I3 => a_{2*i}, I4 => a_{2*i+1}
    # this one is for those whose O6 is the sign bit from I3 => a_{2*i} (inverted)
    # match (I1, I0):
    #     case (0, 0):
    #         O5 = 0
    #         O6 = 1
    #     case (0, 1):
    #         O5 = I3
    #         O6 = NOT(I3)
    #     case (1, 0):
    #         O5 = NOT(I2)
    #         O6 = I3
    #     case (1, 1):
    #         O5 = NOT(I3)
    #         O6 = I3
    # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    # first two bits from  2nd+ rows of the bit heap generation with radix-4 Booth Recoding
    # where a_{2*i-1} is always 1'b0
    # I0 => b_{2*i-1}, I1 => b_{2*i}, I2 => b_{2*i+1}, I3 => a_{2*i}, I4 => a_{2*i+1}
    # this one is for those whose O6 is the sign bit from I3 => a_{2*i} (inverted)
    match (I2, I1, I0):
        case (0, 0, 0):
            O5 = 0
            O6 = 0
        case (0, 0, 1):
            O5 = I3
            O6 = I4
        case (0, 1, 0):
            O5 = I3
            O6 = I4
        case (0, 1, 1):
            O5 = 0
            O6 = I3
        case (1, 0, 0):
            O5 = 1
            O6 = NOT(I3)
        case (1, 0, 1):
            O5 = NOT(I3)
            O6 = NOT(I4)
        case (1, 1, 0):
            O5 = NOT(I3)
            O6 = NOT(I4)
        case (1, 1, 1):
            O5 = 1
            O6 = 1
    return O6, O5


def LUT6_1(I0, I1, I2, I3, I4, I5):
    # put your LUT logic here
    # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    # (6 : 3]
    # First LUT
    # O6 = HA_sum(FA_sum(I0, I1, I2), FA_sum(I3, I4, I5))
    # Second LUT
    # O6 = FA_sum(HA_carry(FA_sum(I0, I1, I2), FA_sum(I3, I4, I5)), FA_carry(I0, I1, I2), FA_carry(I3, I4, I5))
    # Third LUT
    O6 = FA_carry(HA_carry(FA_sum(I0, I1, I2), FA_sum(I3, I4, I5)), FA_carry(I0, I1, I2), FA_carry(I3, I4, I5))
    return O6



def LUT3_1_INIT():
    INIT = 0
    p = 1
    for I2 in range(2):
        for I1 in range(2):
            for I0 in range(2):
                O = LUT3_1(I0, I1, I2)
                INIT += O*p
                p *= 2
    print("8'h"+format(INIT, 'X'))


def LUT5_1_INIT():
    INIT = 0
    p = 1
    for I4 in range(2):
        for I3 in range(2):
            for I2 in range(2):
                for I1 in range(2):
                    for I0 in range(2):
                        O = LUT5_1(I0, I1, I2, I3, I4)
                        INIT += O*p
                        p *= 2
    print("32'h"+format(INIT, 'X'))


def LUT5_2_INIT():
    INIT_l = 0
    INIT_h = 0
    p = 1
    for I4 in range(2):
        for I3 in range(2):
            for I2 in range(2):
                for I1 in range(2):
                    for I0 in range(2):
                        O6, O5 = LUT5_2(I0, I1, I2, I3, I4)
                        INIT_l += O5*p
                        INIT_h += O6*p
                        p *= 2
    INIT = INIT_h*(2**32) + INIT_l
    print("64'h"+format(INIT, 'X'))


def LUT6_1_INIT():
    INIT = 0
    p = 1
    for I5 in range(2):
        for I4 in range(2):
            for I3 in range(2):
                for I2 in range(2):
                    for I1 in range(2):
                        for I0 in range(2):
                            O6 = LUT6_1(I0, I1, I2, I3, I4, I5)
                            INIT += O6*p
                            p *= 2
    print("64'h"+format(INIT, 'X'))



if __name__ == "__main__":
    print("LUT3_1 INIT VALUE:")
    LUT3_1_INIT()
    print("LUT5_1 INIT VALUE:")
    LUT5_1_INIT()
    print("LUT5_2 INIT VALUE:")
    LUT5_2_INIT()
    print("LUT6_1 INIT VALUE:")
    LUT6_1_INIT()

