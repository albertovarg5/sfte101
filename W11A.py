from graphics import graphics                  
      
def smiley(canvas, x, y, size, color):
    # TODO: Implement the function
        canvas.ellipse(x, y, size, size, color)
        canvas.ellipse(x+(size/5), y-(size/5), (size/7), (size/7), 'black')
        canvas.ellipse(x-(size/5), y-(size/5), (size/7), (size/7), 'black')
        canvas.ellipse(x, y+(size/10), (size/2), (size/2), 'black')
        canvas.rectangle(x-(size/3), y-(size/4), (size/1.5), (size/3), color)


