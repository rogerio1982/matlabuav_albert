 %function [Us, Small, Macro, TU] = StartScenario(U, SC, MC)
clearvars
clc;
clear;
close all;

fprintf('========================\n'); 
fprintf('Implementando cenário\n')
fprintf('========================\n'); 

% U ** Total de Usuarios = U*11 **
S=1;% SC Total de SmallCells
MC=1;% M Total de MacroCells
Sim = 0;    % Total de Execuções
U = 100;    % numeros de user

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
    
    %scatter (x_Users,y_Users)

ciclos=10;
fitatual=[];
fittemp=0;
for xx=1:ciclos

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
    
 
    fprintf('ciclos: %d\n', xx); 
    fprintf('Uav qtd: %d\n', S);  
    fittemp(xx)=[fitness];
    if fittemp(xx)>fittemp
        fittemp= fittemp(xx);
    end
    fprintf('fitness: %d\n', round(fittemp));    
 
      %small
    for i=1:S
        small_positions_X(i) = Small(i).X;
        small_positions_Y(i) = Small(i).Y;
    end
     
    x_Smalls=(small_positions_X);
    x_Macro = Macro(1).X;
    y_Smalls=small_positions_Y;
    y_Macro = Macro(1).Y;

S=S+1;
end

fprintf('max fitness: %d', round(max(fittemp))); 

pos=round(max(fittemp));
S=find(fittemp==pos);
fprintf(' na pos: %d\n', S); 

