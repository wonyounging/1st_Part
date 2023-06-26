import glob
print(glob.glob('ca*.py'))      # ca로 시작하는 파이썬 파일의 모든 목록을 반환
print(glob.glob('c:/ca[0-9]'))  # ca 문자열 다음 숫자 1개가 오는 목록을 반환
print(glob.glob('c:/ca[0-9]/*.txt'))  # ca1~9 디렉토리 내 포함된 *.txt(모든 파일) 반환
print(glob.glob('c:/ca[0-9]/[0-9]*.txt'))  # ca1~9 디렉토리 내 숫자 1개 파일 반환
print(glob.glob('c:/cak1/*.txt'))  # cak1 디렉토리 내 모든 txt 파일 반환
print(glob.glob('c:/cak1/?.txt'))  # 1글자 txt 파일 반환