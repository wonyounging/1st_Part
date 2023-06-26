# 출생 연도 세대
year = int(input('출생연도를 입력해주세요 : '))
if year <= 1924:
  gen = '가장 위대한 세대(The Greatest Generation)'
elif (year >= 1925) & (year <= 1945):
  gen = '침묵 세대(The Silent Generation)'
elif (year >= 1946) & (year <= 1964):
  gen = '베이비 부머(The Baby Boomer)'
elif (year >= 1965) & (year <= 1980):
  gen = 'X 세대(Generation X)'
elif (year >= 1981) & (year <= 1996):
  gen = '밀레니얼 세대(Millennial)'
elif (year >= 1997):
  gen = 'Z 세대(Generation Z)'
else:
  pass
print(gen)