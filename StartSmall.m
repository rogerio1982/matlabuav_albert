function [Small] = StartSmall(S, X, Y)


%Px = linspace(X(1,1), X(1,2), S); % Contria um vetor de 10 posições com valores entre Xmin e Xmax
%Py = linspace(Y(1,1), Y(1,2), S); % Contria um vetor de 10 posições com valores entre Ymin e Ymax



Cont = 1; %Contontador para preencher as Small
for j = 1:S
  %  for j = 1:S
        
        Small(j) = StationBase;
        Small(j).ID = j;
        Small(j).X = rand(1) * X(1,2);%Px(i);
        Small(j).Y = rand(1) * Y(1,2);%Py(j);
        Small(j).RP = 33; % dBm 
        Small(j).Fr = 2.6e9; % 2.4 GHz
        Small(j).D = true;
        Small(j).PRB = 100;
        Small(j).PRB_F = 100;
        Small(j).B = 18e6; % 18 MHz 
        Small(j).C = 0;
        Small(j).H = 40;%altura
        Small(j).Cob = (Small(j).H)*5; % Metros (Euclidiana)
        Small(j).UB = 0; % Usuários bloqueados
        Small(j).Int = 0; % Interferencia
        Small(j).MAX_U = 100;
        Small(j).U = 0;
      %  fprintf('small a: %d\n', Small(j).ID);
        Cont = Cont + 1;
        
   % end
end


end

