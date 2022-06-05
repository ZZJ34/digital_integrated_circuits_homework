import random

def random_hex(length):
    result = hex(random.randint(0,16**length)).replace('0x','').upper()
    if(len(result)<length):
        result = '0'*(length-len(result))+result
    return result

if __name__ == "__main__":


    pattern_number = 25
    
    for _ in range(pattern_number):
        a = random_hex(8)
        b = random_hex(8)
        cin = random.randint(0, 1)

        a_c = int('0x'+a, 16)
        b_c = int('0x'+b, 16)

        s = str(hex(a_c + b_c + cin)).upper().split('X')[1]

        s = '0'+s if len(s) == 8 else s

        print(a, end=" ")
        print(b, end=" ")
        print(cin, end=" ")
        print(s)




