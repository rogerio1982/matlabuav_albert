function [DR, CQI, SINR,PRX, I ] = CalculateChannel(U, S, Small)

   
D = (((U.X - S.X)^2) + ((U.Y - S.Y)^2))^0.5;  %Distancia de Euclides

%C = sqrt(abs((D)^2 + (30)^2));

%fprintf('D: %d\n', D);
%fprintf(' C: %d\n', C);


if (D <= S.Cob && S.D)

    WN = 7.4e-13; % Ru�do Branco (CORRIGIR)
    I = 0; % Interferencia gerada por outras c�lulas
    

    D0 = 100; % Dist�ncia Refer�ncia
    Sv = 9.4; % 8.2 to 10.6 dB ==> 
    V = 3e8; % Velocidade da luz (m/s) no vacuo
    L = V / S.Fr; % Lambda
    Hr = 1.2; % Altura de recep��o
    Hb = S.H; % Altura da Esta��oBase,
    E = 16; % Equalizado

    % Par�metros Cen�rio SUI
    a = 3.6;
    b = 0.005;
    c = 20;


    A = 20 * log10( 4*pi*D0/L ); 
    Y = ( a- ( b*Hb )) + ( c/Hb );

    Lost = A + 10*Y*log10( D/D0 )+ Sv - E; % Perda no Canal

    Pw = 10^((S.RP - Lost)/10)/1000;
    

    for i = 1:length(Small) % calculate intercell interference

        if(Small(i).D && Small(i).ID ~= S.ID)
            Da = (((Small(i).X - U.X)^2) + ((Small(i).Y - U.Y)^2))^0.5;
            LostA = Small(i).RP - (A + 10*Y*log10 (Da/D0)+ Sv - E);
            I = I + (10^(LostA/10))/1000;
        end

    end
    
    %I = 0; % Considerar apenas ru�do branco
    
    Pdbm = 10 * log10(1000 * Pw);
    WNdbm = -91.31;
    Idbm = 10 * log10(1000 * I);
    SINRw = (Pw / (WN + I));
    SINR = 10 * log10(1000 * SINRw);

    C = S.B / S.PRB;%smallcell
    DR = (C * log2(1+SINRw)); % Datarate com apenas 1 PRB sendo usado/shannon.
%   CQI = round(1 + ((7/13)*(SINR+6)));
    CQI = round(1 + ((7/13)*(SINRw+6)));
    PRX =round(Pdbm);
   
else
    
    SINR = 0;
    DR = 0;
    CQI = 0;
    I = 0;
    PRX = 0;


end


end

