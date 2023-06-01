function [Small] = StartSmall(S, X, Y,v1,v2,distancia)

%v1=[100,200,300];
%v2=[200,300,400];
%distancia=distancia.';
Cont = 1; %Contontador para preencher as Small
for j = 1:S
  %  for j = 1:S
   
        Small(j) = StationBase;
        Small(j).ID = j;
        Small(j).X = v1(j);%rand(1) * X(1,2);%Px(i); rand(10,2)
        Small(j).Y = v2(j);%rand(1) * Y(1,2);%Py(j); rand(10,2)
        Small(j).RP = 33; % dBm 
        Small(j).Fr = 2.6e9; % 2.4 GHz
        Small(j).D = true;
        Small(j).PRB = 100;
        Small(j).PRB_F = 100;
        Small(j).B = 18e6; % 18 MHz 
        Small(j).C = 0;
        Small(j).H = round(distancia(j)/5);%altura
        Small(j).Cob = round(distancia(j));%(Small(j).H)*3; % Metros (Euclidiana)
        Small(j).UB = 0; % Usuários bloqueados
        Small(j).Int = 0; % Interferencia
        Small(j).MAX_U = 100;
        Small(j).U = 0;
      %  fprintf('small a: %d\n', Small(j).ID);
        Cont = Cont + 1;

   % end
end


end

