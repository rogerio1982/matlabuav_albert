%Fórmula do tempo de voo do drone
clc;
clear;
close all;

x=1:1000;
y=[];
variacao=0;
for k=1:1000
        AUW=2.5; %PESO
        P=170; %POTENCIA WATTS NECESSÁRIO PARA LEVANTAR 1 KG
        V=36; %VOLTAGEM BATERIA
        capacity=8.8;%AMPERES DA BATERIA
        discharge=0.8;%PERCENTUAL DE USO DA BATERIA
        
        %diferentes altitudes produzem diferentes forcas de vento. 
        %além de ter mais gasto em amperes para subir o drone
        vento=0.2;
        variacao=rand(1);
        
        P=P+variacao;
        
        AAD = AUW * P / V;% CONSUMO MEDIO DE CORRENTE amperes
        
        time = (capacity * discharge) / AAD; 
        

        
        y(k)= AAD;
end
        fprintf('AAD: %d\n', round(AAD));
        time=(time*60);%multiplica o resultado pela 60min
        fprintf('time: %d\n', time);%min
plot(x,y)


