 %function [Us, Small, Macro, TU] = StartScenario(U, SC, MC)
clearvars
clc;
clear;
close all;

fprintf('========================\n'); 
fprintf('Implementando cenário\n')
fprintf('========================\n'); 

% U ** Total de Usuarios = U*11 **
S=5;% SC Total de SmallCells
MC=1;% M Total de MacroCells
Sim = 0;    % Total de Execuções
U = 10;    % numeros de user

% Eixos dos cenários.  (Área total = 4 Km²)
X(1,:) = [0 1000]; % Eixo X minimo e máximo.
Y(1,:) = [0 1000]; % Eixo Y minimo e máximo.

%plot all


%gerar usuarios 
[User] = StartUser(U, X, Y); % Função para iniciar os usuários

 for i=1:U
        users_positions_X(i) = User(i).X;
        users_positions_Y(i) = User(i).Y;
    end
    x_Users = users_positions_X;
    y_Users = users_positions_Y;
    
    scatter (x_Users,y_Users)



    %cluster
    all_xy=[x_Users.',y_Users.'];%matriz transposta .'
    [idx,C,sumd, D] = kmeans(all_xy,S);
    teste=[C(:,1),C(:,2)];
    
    %uav na posicao centra do cluster
    v1=C(:,1);
    v2=C(:,2);
    
    %distancia de todos os usuários para o uav do cluster
    maxDistances=[];
    for k = 1 : S
        % Get x and y of centroid.
        xc = C(k, 1);
        yc = C(k, 2);
        % Get the x and y coordinates of points within this class only.
        inClass = idx == k; % Indexes of points that were assigned to this class.
        x = all_xy(inClass, 1); % Get not ALL x, but just x within this one class.
        y = all_xy(inClass, 2); % Get not ALL y, but just y within this one class.
        % Get distances of all points in the class to the centroid for this class.
        distances = sqrt((x - xc) .^ 2 + (y - yc) .^ 2);

        maxDistances(k)= max(distances);

    end
    maxDistances=double(transpose(maxDistances));



    %[Small] = StartSmall(S, X, Y); % Função para iniciar as SmallCells 
    [Small] = StartSmall(S, X, Y,v1,v2,maxDistances);
    [Macro] = StartMacro(MC, X, Y); % Função para iniciar as MacriCells
    [Us1, S1,fitness] = ConexaoUsM(User, Small); % Usuários e Small
    %[Us1, S1] = ConexaoUs_alt(User, Small); % Usuários e Small
 
      %small
    for i=1:S
        small_positions_X(i) = Small(i).X;
        small_positions_Y(i) = Small(i).Y;
    end
     
    x_Smalls=(small_positions_X);
    x_Macro = Macro(1).X;
    y_Smalls=small_positions_Y;
    y_Macro = Macro(1).Y;



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
 %% fprintf('xy: %d\n', radius);    

end

plot(x_Smalls,y_Smalls, 'o', 'color', 'blue');
hold on
plot(x_Macro,y_Macro, '^', 'MarkerSize', 8);
hold on
plot(x_Users,y_Users, '*', 'color','red');
hold on
legend1 = legend('','','UAV', 'ERB', 'Users');
set(legend1,'Location','northeastoutside');

%plot cluster 2d
figure
gscatter(all_xy(:,1),all_xy(:,2),idx,'rgb')
hold on
plot(C(:,1),C(:,2),'kx')
%legend('Cluster 1','Cluster 2','Cluster 3','Cluster Centroid')

%fprintf('distancia: %d\n', round(maxDistances));
%fprintf('teste: %d\n', round(teste));


%% Plotting 3d

figure('Name', 'Communication Ranges', 'units','normalized','outerposition', ...
    [0 0 1 1]);

for i=1:idx
    %alteracao para plot 3d
    x_circle_uav = C(i, 1) ;
    y_circle_uav = C(i, 2) ;
    %z = duration(0,maxDistances(i),1);
    z = duration(0,50,1);

    %plot3(x_circle_uav,y_circle_uav,z,'X','DurationTickFormat','mm:ss')
    plot3(x_circle_uav,y_circle_uav,z,'X','MarkerSize',20, 'LineWidth',3)

    xlabel('X')
    ylabel('Y')
    zlabel('height')
    hold on;
end

users = gscatter(x_Users,y_Users, idx,"",".",20);
hold on;
%axis equal;

%legend([p_centroid,p_center,users], 'UAV', 'Base Station');
%legend([p_centroid],'UAVs')

title(' 3D Coverage UAV Base stations ');
xlabel('1000 meters');
ylabel('1000 meters');

