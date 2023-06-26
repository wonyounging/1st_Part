def value_print(x):
    print(x)
    print(type(x))
    print(f'지금 사용하는 변수는 {x}이고, 타입은 {type(x)}입니다.')

a = value_print(2)
b = value_print('string')

def hello():
    print('hello world!')

hello()

#함수는 순서를 지켜야함
# hello2()
# def hello2():
# print('hello world!')

def hello3():
    pass

hello3()

# 덧셈함수 선언
def sum_mul(x,y):
    result_sum = x + y
    result_min = x - y
    result_mul = x * y

    return result_sum, result_mul, result_min

# 함수 호출
a = sum_mul(5,6)
print(a)

def sum(x,y):
    print(x + y)
c = sum(400,800)

# 언패킹
x = (18, 20, 30)
print(x)
print(*x) # 언패킹

def print_num(a, b, c):
    print(a)
    print(b)
    print(c)
print_num(10, 20, 30)

x = [7,8,9]
y = (11,22,33)

print_num(*x)
print_num(*y)

def sum_many(*args):        #arguments
    sum = 0
    for i in args:
        sum += i
    return sum

result = sum_many(1,2,3,4,5,6,7,8,9,10)
print(result)
