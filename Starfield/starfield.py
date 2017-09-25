import tkinter as tk
import time
import random as rd
import math


class Star():
    def __init__(self):
        self.x = rd.randint(4, 396)
        self.y = rd.randint(4, 396)
        self.d = math.sqrt((self.x-200)**2 + (self.y-200)**2)
        self.oval = canvas.create_oval(self.x-1, self.y-1, self.x+1, self.y+1, fill='white')


win = tk.Tk()

canvas = tk.Canvas(win, width = 400, height = 400, background = 'black')
canvas.pack()



starz = []
for i in range(30):
    s = Star()
    starz.append(s)

while True:
    time.sleep(0.01)
    for i, s in enumerate(starz):
        if abs(s.x-200) >= 202 or abs(s.y-200) >= 202:
            canvas.delete(s.oval)
            starz[i] = Star()
        else:
            dx = (s.x-200)/20
            dy = (s.y-200)/20
            canvas.move(s.oval, dx, dy)
            s.x = s.x + dx
            s.y = s.y + dy
    canvas.update()


















# button_quit = tk.Button(win, text='Quit now !', command = win.quit)
# button_quit.pack()

# while True:
#     time.sleep(0.1)
#     canvas.move(star, 3, 0)
#     canvas.update()


win.mainloop()


# root = Tk()
# canv = Canvas(root, highlightthickness=0)
# canv.pack(fill='both', expand=True)
# top = canv.create_line(0, 0, 640, 0, fill='green', tags=('top'))
# left = canv.create_line(0, 0, 0, 480, fill='green', tags=('left'))
# right = canv.create_line(639, 0, 639, 480, fill='green', tags=('right'))
# bottom = canv.create_line(0, 478, 640, 478, fill='red', tags=('bottom'))
#
# rect = canv.create_rectangle(270, 468, 365, 478, outline='black', fill='gray40', tags=('rect'))
# ball = canv.create_oval(0, 20, 20, 40, outline='black', fill='gray40', tags=('ball'))
#
# delta_x = delta_y = 3
# new_x, new_y = delta_x, -delta_y
# while True:
#     time.sleep(0.025)
#     if canv.find_overlapping(canv.coords(ball)[0], canv.coords(ball)[1], canv.coords(ball)[2], canv.coords(ball)[3])[0] == 1:
#         new_x, new_y = delta_x, -delta_y
#         canv.move(ball, new_x, new_y)
#         print 'fitst if', new_x, new_y
#     if canv.find_overlapping(canv.coords(ball)[0], canv.coords(ball)[1], canv.coords(ball)[2], canv.coords(ball)[3])[0] == 2:
#         new_x, new_y = delta_x, delta_y
#         canv.move(ball, new_x, new_y)
#         print '2nd if', new_x, new_y
#     if canv.find_overlapping(canv.coords(ball)[0], canv.coords(ball)[1], canv.coords(ball)[2], canv.coords(ball)[3])[0] == 3:
#         new_x, new_y = -delta_x, delta_y
#         canv.move(ball, new_x, new_y)
#     if canv.find_overlapping(canv.coords(ball)[0], canv.coords(ball)[1], canv.coords(ball)[2], canv.coords(ball)[3])[0] == 4:
#         new_x, new_y = delta_x, -delta_y
#         canv.move(ball, new_x, new_y)
#     print new_x, new_y
#     canv.move(ball, new_y, new_y)
#     canv.update()
#
# def move_right(event):
#         canv.move(rect, 7, 0)
#         pass
#
# def move_left(event):
#     canv.move(rect, -7, 0)
#     pass
#
# root.bind('<Right>', move_right)
# root.bind('<Left>', move_left)
#
# root.geometry('%sx%s+%s+%s' %(640, 480, 100, 100))
# root.resizable(0, 0)
# root.mainloop()



