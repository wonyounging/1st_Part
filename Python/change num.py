# 길이, 부피, 무게나 금액을 표기할 때 1000을 'k'로 표기하곤 합니다.
num = int(input('단위를 입력해주세요(입력은 10의 배수만 입력하세요.) : '))
if num < 1000:
  print(num)
elif (num >= 1000) & (num < 1000000):
  change = num * 0.001
  print(f'{change:.2f}' + 'K')
elif (num >= 1000000) & (num < 1000000000):
  change = num * 0.000001
  print(f'{change:.2f}' + 'M')
elif (num >= 1000000000) & (num < 1000000000000):
  change = num * 0.000000001
  print(f'{change:.2f}' + 'T')
elif (num >= 1000000000000) & (num < 1000000000000000):
  change = num * 0.000000000001
  print(f'{change:.2f}' + 'p')
elif (num >= 1000000000000000) & (num < 1000000000000000000):
  change = num * 0.000000000000001
  print(f'{change:.2f}' + 'E')
else:
  pass
