def get_puls(a,b):
    return a+b

def get_minus(a,b):
    return a-b

def get_mul(a,b):
    return a*b

def get_division(a,b):
    if b != 0:
        return a/b
    else:
        return 'zero division error'