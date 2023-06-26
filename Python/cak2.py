# 모듈 별칭을 사용해서 계산 기능사용
# 모듈이름을 붙이지 않고 함수 사용하기
# 2개 함수만 함수명 1, 함수명2
# 함수명3을 가져올때 어떻게 동작되는지
# 3. *로 가져오는 방식으로 동작

import myCak as my
print(my.get_puls(10,40))
print(my.get_minus(55,23))
print(my.get_mul(1,48))
print(my.get_division(56,2))

# from myCak import get_puls, get_minus
# print(get_puls(10,40))
# print(get_minus(55,23))

# from myCak import *
# print(my.get_puls(10,40))
# print(my.get_minus(55,23))
# print(my.get_mul(1,48))
# print(my.get_division(56,2))