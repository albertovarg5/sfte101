const canvas = document.getElementById('gameCanvas');
const ctx = canvas.getContext('2d');
const restartBtn = document.getElementById('restartBtn');
const scoreDisplay = document.getElementById('score');

const box = 20;
const gridWidth = canvas.width / box;
const gridHeight = canvas.height / box;

let snake, direction, food, score, gameInterval;

function initGame() {
  snake = [{ x: 9 * box, y: 10 * box }];
  direction = "RIGHT";
  score = 0;
  scoreDisplay.innerText = "Score: 0";
  food = generateFood();
  clearInterval(gameInterval);
  gameInterval = setInterval(draw, 150); // Slower snake (changed from 100 to 150)
}

function generateFood() {
  return {
    x: Math.floor(Math.random() * gridWidth) * box,
    y: Math.floor(Math.random() * gridHeight) * box
  };
}

document.addEventListener("keydown", e => {
  if (e.key === "ArrowLeft" && direction !== "RIGHT") direction = "LEFT";
  else if (e.key === "ArrowUp" && direction !== "DOWN") direction = "UP";
  else if (e.key === "ArrowRight" && direction !== "LEFT") direction = "RIGHT";
  else if (e.key === "ArrowDown" && direction !== "UP") direction = "DOWN";
});

document.getElementById('upBtn').addEventListener('click', () => {
  if (direction !== "DOWN") direction = "UP";
});
document.getElementById('downBtn').addEventListener('click', () => {
  if (direction !== "UP") direction = "DOWN";
});
document.getElementById('leftBtn').addEventListener('click', () => {
  if (direction !== "RIGHT") direction = "LEFT";
});
document.getElementById('rightBtn').addEventListener('click', () => {
  if (direction !== "LEFT") direction = "RIGHT";
});

function collision(head, array) {
  return array.some(segment => head.x === segment.x && head.y === segment.y);
}

function draw() {
  // Check for collisions before the snake moves
  let head = { x: snake[0].x, y: snake[0].y };

  if (direction === "LEFT") head.x -= box;
  if (direction === "UP") head.y -= box;
  if (direction === "RIGHT") head.x += box;
  if (direction === "DOWN") head.y += box;

  // End game if the snake hits the wall
  if (
    head.x < 0 || head.x >= canvas.width ||
    head.y < 0 || head.y >= canvas.height ||
    collision(head, snake)
  ) {
    clearInterval(gameInterval);
    alert("Game Over! Score: " + score);
    return;
  }

  // Move the snake
  snake.unshift(head);

  // Check if the snake eats food
  if (head.x === food.x && head.y === food.y) {
    score++;
    scoreDisplay.innerText = "Score: " + score;
    food = generateFood();
  } else {
    snake.pop();
  }

  // Redraw everything
  ctx.fillStyle = "#000";
  ctx.fillRect(0, 0, canvas.width, canvas.height);

  for (let i = 0; i < snake.length; i++) {
    ctx.fillStyle = i === 0 ? "lime" : "#0f0";
    ctx.fillRect(snake[i].x, snake[i].y, box, box);
  }

  ctx.fillStyle = "red";
  ctx.fillRect(food.x, food.y, box, box);
}

restartBtn.addEventListener('click', initGame);
initGame();