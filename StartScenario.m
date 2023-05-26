 %function [Us, Small, Macro, TU] = StartScenario(U, SC, MC)
clearvars
clc;
clear;
close all;

fprintf('========================\n'); 
fprintf('Implementando cenário\n')
fprintf('========================\n'); 

% U ** Total de Usuarios = U*11 **
S=3;% SC Total de SmallCells
MC=1;% M Total de MacroCells
Sim = 0;    % Total de Execuções
U = 10;    % numeros de user

% Eixos dos cenários.  (Área total = 4 Km²)
X(1,:) = [0 1000]; % Eixo X minimo e máximo.
Y(1,:) = [0 1000]; % Eixo Y minimo e máximo.


% Confirmar os parâmetros usados % ----------------------------------------
% -------------------------------------------------------------------------

[User] = StartUser(U, X, Y); % Função para iniciar os usuários

[Small] = StartSmall(S, X, Y); % Função para iniciar as SmallCells 

[Macro] = StartMacro(MC, X, Y); % Função para iniciar as MacriCells


[Us1, S1] = ConexaoUsM(User, Small); % Usuários e Small
%[Us1, S1] = ConexaoUs_alt(User, Small); % Usuários e Small

%small
for i=1:S
    small_positions_X(i) = Small(i).X;
    small_positions_Y(i) = Small(i).Y;

end

%user
for i=1:U
    users_positions_X(i) = User(i).X;
    users_positions_Y(i) = User(i).Y;
end

x_Smalls=(small_positions_X);
x_Macro = Macro(1).X;
x_Users = (users_positions_X);

y_Smalls=small_positions_Y;
y_Macro = Macro(1).Y;
y_Users=users_positions_Y;


%plot all
figure1 = figure('Name', 'Cenário Inicial','Color',[1 1 1]);
axes1 = axes('Parent',figure1);
hold(axes1,'on');

%calcula o raio da erb
for i=1:S
    angles = linspace(0, 2*pi, 50);
    radius =Small(i).Cob;
    CenterX = Small(i).X;
    CenterY = Small(i).Y;
    x = radius * cos(angles) + CenterX;
    y = radius * sin(angles) + CenterY;  

    plot(x, y, 'b-', 'LineWidth', 2);
    hold on;
    axis equal;
end

plot(x_Smalls,y_Smalls, 'o', 'color', 'blue');
hold on
plot(x_Macro,y_Macro, '^', 'MarkerSize', 8);
hold on
plot(x_Users,y_Users, '*', 'color','red');
hold on
legend1 = legend('','','UAV', 'ERB', 'Users');
set(legend1,'Location','northeastoutside');















%end

