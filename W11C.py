def smiley(canvas, x, y, size, color):
    '''
    Draws a smiley face wherever we want!
    Parameter information:
       * canvas: the graphics object to draw the plus on.
       * x and y: The coordinates for the center of the plus.
       * size: determines the width and height.
       * color: The fill color.
    '''
    canvas.ellipse(x, y, size, size, color)
    canvas.ellipse(x, y+(size/10), (size/2), (size/2), 'black')
    canvas.rectangle(x-(size/3), y-(size/4), (size/1.5), (size/3), color)
    canvas.ellipse(x+(size/5), y-(size/5), (size/7), (size/7), 'black')
    canvas.ellipse(x-(size/5), y-(size/5), (size/7), (size/7), 'black')

    def main():
    gui = graphics(500, 500, 'plusses')
    gui.rectangle(0, 0, 500, 500, 'white')
    smiley(gui, 125, 125, 200, 'orange')
    smiley(gui, 125, 375, 200, 'light green')
    smiley(gui, 375, 125, 200, 'light blue')
    smiley(gui, 375, 375, 200, 'purple')
    gui.draw()

main()