angles = linspace(0, 2*pi, 50);
radius = 20;
CenterX = 50;
CenterY = 40;
x = radius * cos(angles) + CenterX;
y = radius * sin(angles) + CenterY;
plot(x, y, 'b-', 'LineWidth', 2);
hold on;
plot(CenterX, CenterY, 'k+', 'LineWidth', 3, 'MarkerSize', 14);
grid on;
axis equal;
xlabel('X', 'FontSize', 9);
ylabel('Y', 'FontSize', 9);