clear % limpa o espa?o de vari?veis do Matlab
clc % limpa a command window

load ambienteTeste.mat
%load ambiente1.mat
%load ambiente2.mat

V = ones(MDP.S,1) * 3
matrizPV = zeros(MDP.S, MDP.A)

for s = 1:MDP.S
    for a = 1:MDP.A
        prob = MDP.T{a}(s,:) % probabilidade de ir de s a s' pela a??o a
        matrizPV(s,a) = prob * V;
    end
end
matrizPV