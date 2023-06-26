# if 문을 활용해서 가위바위보 게임 만들기
# 변수 : 가위, 바위, 보, 이김, 비김, 짐, 나의 변수, 컴퓨터 변수
import random
rsp = ['바위', '가위', '보']

scissor = '가위'
rock = '바위'
paper = '보'
win = '이겼다!'
draw = '비겼다.'
lose = '졌다.'

print('----가위바위보 게임(종료는 \'q\')----')
while 1:
  user = str(input())
  com = random.choice(rsp)
  if user == 'q':
    print('종료')
    break
  elif user == com:
    result = draw
  else:
    if user == scissor:
      if com == rock:
        result = lose
      else:
        result = win
    elif user == rock:
      if com == paper:
        result = lose
      else:
        result = win
    else:
      if com == scissor:
        result = lose
      else:
        result = win
  print(f'User : {user}\tCom : {com}')
  print(result)