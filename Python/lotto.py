import random

num = int(input('Lotoo 게임 수를 입력하세요 : '))
print('--Lotto 자동번호 입니다.--')
print('--------------------------')
for x in range(1, num + 1):
    lotto = [0, 0, 0, 0, 0, 0]
    lotto[0] = random.randrange(1, 46, 1)

    lotto[1] = lotto[0]
    lotto[2] = lotto[0]
    lotto[3] = lotto[0]
    lotto[4] = lotto[0]
    lotto[5] = lotto[0]

    while (lotto[0] == lotto[1]):
        lotto[1] = random.randrange(1, 46, 1)
    while (lotto[0] == lotto[2] or lotto[1] == lotto[2]):
        lotto[2] = random.randrange(1, 46, 1)
    while (lotto[0] == lotto[3] or lotto[1] == lotto[3] or lotto[2] == lotto[3]):
        lotto[3] = random.randrange(1, 46, 1)
    while (lotto[0] == lotto[4] or lotto[1] == lotto[4] or lotto[2] == lotto[4] or lotto[3] == lotto[4]):
        lotto[4] = random.randrange(1, 46, 1)
    while (lotto[0] == lotto[5] or lotto[1] == lotto[5] or lotto[2] == lotto[5] or lotto[3] == lotto[5] or lotto[4] ==
           lotto[5]):
        lotto[5] = random.randrange(1, 46, 1)

    print(lotto)