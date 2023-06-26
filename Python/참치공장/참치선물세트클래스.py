class 참치선물세트():
    def __init__(self, 일반, 야채, 고추):
        self.normal = 일반
        self.veg = 야채
        self.pepper = 고추
    def 출력(self, 이름):
        print('**', 이름, '**')
        print('일반 참치 : ', self.일반)
        print('야채 참치 : ', self.야채)
        print('고추 참치 : ', self.고추)