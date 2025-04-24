from graphics import graphics

canvas= graphics(500,350,"animation")

def mouse_left(c, x, y):
    diameter = 75
    c.ellipse(x, y, diameter, diameter, "gray")
def mouseClickBall():
    global canvas
    canvas.set_left_click_action(mouse_left)
    canvas.rectangle(0, 0, 500, 350, "orange")
    while True:
        canvas.update_frame(30)  # display frame and delay to achieve 30FPS

# fallingBall()
# bouncingBall()
# bouncingBallWithGravity()
# ballWithMouse()
mouseClickBall()