import random
rand_num = random.randint(1,100)
print(f'정답 : {rand_num}')
while 1:
  me = int(input())
  if rand_num > me:
    print('Up')
  elif rand_num < me:
    print('Down')
  elif rand_num == me:
    print('Bingo')
    break