from tkinter import *
root = Tk()
root.title("혼공 GUI 연습")
root.geometry("400x200")

label1 = Label(root, text="혼공은 SQL은")
label2 = Label(root, text="쉽습니다.", font=('궁서체', 30), bg = 'blue', fg = 'yellow')

label1.pack()
label2.pack()
root.mainloop()