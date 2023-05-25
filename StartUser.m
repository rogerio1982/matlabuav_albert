function [Us] = StartUser(U, X, Y)
%D = [0.9 0.69 0.56 0.48 0.39 0.29 0.25 0.20 0.19 0.23 0.30 0.57...
%    0.87 0.92 0.73 0.61 0.74 0.89 0.85 0.75 0.72 0.81 0.96 1]; % Distribuição dos usuários 

T = 400 * 1024; % Taxa Requerida --> 400 Kbps
a = 1;

for j = 1:U
   % UN = U * D(j); % NY
  %  TU(j) = UN;
   % fprintf('user of a: %d\n', j);
  %  for i = 1:UN % Criação de usuários.
        Us(j) = User;
        Us(j).X = rand(1) * X(1,2);
        Us(j).Y = rand(1) * Y(1,2);
        Us(j).R_DR = T;
        Us(j).M = j;
        a = a + 1;
     %    fprintf('DR of a: %d\n', Us(j).R_DR);
  %  end
end




end

