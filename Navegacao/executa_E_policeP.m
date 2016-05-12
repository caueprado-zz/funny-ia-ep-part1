clear;
clc;
gama = 0.9;
erro = 0.0000000000000000000001;
load ambienteTeste.mat;
%load ambiente1.mat;
%load ambiente2.mat;
PoliticaOtima = policyIteration3(MDP,gama, erro);
