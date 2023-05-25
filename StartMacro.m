function [MC] = StartMacro(M, X, Y)



Px = X(1, 2)/2;
Py = Y(1, 2)/2;

Cont = 1;
for i = 1:M
    for j = 1:M
        
        MC(Cont) = StationBase;
        fprintf('macro\n ')
        MC(Cont).ID = Cont;
        MC(Cont).X = Px(i);
        MC(Cont).Y = Py(j);
        MC(Cont).RP = 43; % dBm
        MC(Cont).Fr = 2.6e9; % 3.5 GHz
        MC(Cont).D = true;
        MC(Cont).PRB = 100;
        MC(Cont).PRB_F = 100;
        MC(Cont).B = 18e6; % 18MHz
        MC(Cont).C = 0;
        MC(Cont).Cob = 300; % Metros (Euclidiana)
        MC(Cont).H = 20;
        
        Cont = Cont + 1;
    end
end





end

