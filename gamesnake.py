import pygame
import random

# Initialize pygame
pygame.init()

# Screen settings
width, height = 600, 400
screen = pygame.display.set_mode((width, height))
pygame.display.set_caption("Snake Game with Restart Button")

# Colors
white = (255, 255, 255)
black = (0, 0, 0)
green = (0, 200, 0)
red = (200, 0, 0)
bright_green = (0, 255, 0)
bright_red = (255, 0, 0)

# Snake & game settings
block_size = 20
snake_speed = 15
clock = pygame.time.Clock()
font = pygame.font.SysFont('arial', 25)

# Draw the score
def display_score(score):
    text = font.render(f"Score: {score}", True, white)
    screen.blit(text, [10, 10])

# Draw snake
def draw_snake(block_size, snake_list):
    for x in snake_list:
        pygame.draw.rect(screen, green, [x[0], x[1], block_size, block_size])

# Draw button
def draw_button(msg, x, y, w, h, ic, ac, action=None):
    mouse = pygame.mouse.get_pos()
    click = pygame.mouse.get_pressed()

    # Hover effect
    if x+w > mouse[0] > x and y+h > mouse[1] > y:
        pygame.draw.rect(screen, ac, (x, y, w, h))
        if click[0] == 1 and action:
            action()
    else:
        pygame.draw.rect(screen, ic, (x, y, w, h))

    text_surf = font.render(msg, True, black)
    text_rect = text_surf.get_rect(center=((x + w/2), (y + h/2)))
    screen.blit(text_surf, text_rect)

# Game over screen
def game_over_screen(score):
    while True:
        screen.fill(black)
        msg = font.render("Game Over!", True, red)
        score_msg = font.render(f"Final Score: {score}", True, white)
        screen.blit(msg, [width/2 - 70, height/3])
        screen.blit(score_msg, [width/2 - 80, height/3 + 40])

        draw_button("Restart", 150, 250, 120, 50, green, bright_green, game_loop)
        draw_button("Quit", 330, 250, 120, 50, red, bright_red, quit_game)

        pygame.display.update()
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                quit_game()

# Quit function
def quit_game():
    pygame.quit()
    quit()

# Game loop
def game_loop():
    x = width / 2
    y = height / 2
    x_change = 0
    y_change = 0

    snake_list = []
    length_of_snake = 1

    foodx = round(random.randrange(0, width - block_size) / 20.0) * 20.0
    foody = round(random.randrange(0, height - block_size) / 20.0) * 20.0

    running = True
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                quit_game()
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_LEFT:
                    x_change = -block_size
                    y_change = 0
                elif event.key == pygame.K_RIGHT:
                    x_change = block_size
                    y_change = 0
                elif event.key == pygame.K_UP:
                    y_change = -block_size
                    x_change = 0
                elif event.key == pygame.K_DOWN:
                    y_change = block_size
                    x_change = 0

        if x >= width or x < 0 or y >= height or y < 0:
            game_over_screen(length_of_snake - 1)

        x += x_change
        y += y_change
        screen.fill(black)
        pygame.draw.rect(screen, red, [foodx, foody, block_size, block_size])

        snake_head = [x, y]
        snake_list.append(snake_head)
        if len(snake_list) > length_of_snake:
            del snake_list[0]

        for segment in snake_list[:-1]:
            if segment == snake_head:
                game_over_screen(length_of_snake - 1)

        draw_snake(block_size, snake_list)
        display_score(length_of_snake - 1)
        pygame.display.update()

        if x == foodx and y == foody:
            foodx = round(random.randrange(0, width - block_size) / 20.0) * 20.0
            foody = round(random.randrange(0, height - block_size) / 20.0) * 20.0
            length_of_snake += 1

        clock.tick(snake_speed)

# Start the game
game_loop()