function [Us, Small] = ConexaoUsM(Us, Small)

    S = length(Small);
    U = length (Us);
   
     
    for i = 1:U
        for j = 1:S
                   [DR(i,j), CQI(i,j), SINR(i,j)] = CalculateChannel(Us(i), Small(j), Small);  
                  %c
        end
    end   % Calcula o SINR, CQI e DR (1 PRB) de cada usuário para cada Small
    
    
    
    % Identificando a quantidade PRB requisitadas por cadas usuário
cont=0;
    for  i=1:U
        
        [T, ~] = max(DR(i,:)); 
        PR = ceil(Us(i).R_DR/T);
        number_of_prbs_requested_by_users(i,1) = i;
        number_of_prbs_requested_by_users(i,2) = PR;
        %fprintf('user: %d', i);
        %fprintf('number_of_prbs: %d\n', PR);
    end   
    
    % A prioridade de conexão será primeiro para os usuários que demandam
    % "poucos" PRB, ou seja, cujo sinal possue maior qualidade
    % Organizando em ordem crescente pela quantidade de PRB requisitados de cada usuário
    number_of_prbs_requested_by_users =  sortrows(number_of_prbs_requested_by_users, 2);
    
    
    for user_index = 1:U
        aux = 0;
        i = number_of_prbs_requested_by_users(user_index,1);
        
     if (Us(i).C == false)
        
      while  aux == 0
          [T, Ind] = max(DR(i,:)); 
          PR = ceil(Us(i).R_DR/T);
          
          if (Small(Ind).PRB_F >= PR)
                Us(i).DR = T * PR;
                Us(i).PRB = PR;
                Us(i).EB = Ind;
                Us(i).ES = 1; %1 small 2macro
                Us(i).CQI = CQI(i,Ind);
                Us(i).SINR = SINR(i,Ind);
                Us(i).C = true;
                aux = 1;
                Small(Ind).PRB_F = Small(Ind).PRB_F - PR; %subtrai os PRB do small cell
                Small(Ind).U = Small(Ind).U + 1;
        %relatorio    

        fprintf('usuário ON: %d', user_index); 
        fprintf(' | DR %d:',  Us(i).R_DR);
        fprintf(' | PRB %d:',  Us(i).PRB); 
        fprintf(' | CQI %d:',  Us(i).CQI);
        fprintf(' | SINR %d:',  Us(i).SINR);
        fprintf(' | uavbs: %d',  Small(Ind).ID);
        fprintf(' | na pos x : %d',  Us(i).X); fprintf(' e y : %d\n',  Us(i).Y);

        cont=cont+1;

          else
              DR(i,Ind) = 0;
        fprintf('usuário OFF: %d', user_index); 
        fprintf(' | DR %d:',  Us(i).R_DR);
        fprintf(' | PRB %d:',  Us(i).PRB); 
        fprintf(' | CQI %d:',  Us(i).CQI);
        fprintf(' | SINR %d:',  Us(i).SINR);
        fprintf(' | uavbs: %d',  Small(Ind).ID);
        fprintf(' | na pos x : %d',  Us(i).X); fprintf(' e y : %d\n',  Us(i).Y);
          end
      
          if (T == 0)
                 
                Us(i).DR = 0;
                Us(i).PRB = 0;
                Us(i).EB = 0;
                Us(i).CQI = 0;
                Us(i).SINR = 0;
                Us(i).C = false;
                aux = 1;
          end
      
      end
     end
      
   
    end  % Conecta os usuários 
    %relatorio  
    fprintf('\n'); 
    fprintf('Total usuário %d\n', U);
    fprintf('Alocados %d\n',  cont); 
    fprintf('OFF %d\n',  U-cont);
    
    fprintf('\n'); 

   for j = 1:S
     cont = 1;  
     Small(j).VU = [];
     %relatorio        
     fprintf('UAVBS %d\n', Small(j).ID);
     fprintf('PRBs disponíveis %d\n',Small(j).PRB_F);
     fprintf('Usuário alocados %d\n', Small(j).U);
     fprintf('Altura: %d\n',  Small(j).H);
     fprintf('Raio coberto: %d\n',  Small(j).Cob);

     fprintf('\n');

     for i = 1:U
        if (Us(i).EB == j && Us(i).ES == 2)
            Small(j).VU(cont) = i;
            cont = cont + 1;

        end 
     end
            
            Small(j).U = length(Small(j).VU);
            
   end





end

