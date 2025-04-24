from graphics import graphics

canvas= graphics(500,350,"animation")

def ballWithMouse():
    global canvas
    diameter = 75
    while True:
        canvas.clear()  
        canvas.rectangle(0, 0, 500, 350,"orange")
        canvas.ellipse(canvas.mouse_x,canvas.mouse_y, diameter, diameter, "gray")
        canvas.update_frame(30)  # display frame and delay to achieve 30FPS

# fallingBall()
# bouncingBall()
# bouncingBallWithGravity()
ballWithMouse()
