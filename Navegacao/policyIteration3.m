function PoliticaOtima = policyIteration3(MDP, gama, erro)

U = zeros(MDP.S, 1);
PoliticaOtima = ones(MDP.S, 1);

% Passo 1: PoliticaProposta(*) = 1
PoliticaProposta = ones(MDP.S, 1);

 
    inicio = datetime('now')
for iterations = 1:300,
    dif = 1;
    while dif > erro % verifica se a Politica gerou melhorias
   % for i = 1:3000,
        U_linha = zeros(MDP.S, 1);
        % Passo 2 -  (avaliação da política)
        fprintf('\n Avaliação de Política. Iteração: %d',i);
        for s = 1:MDP.S       
            % Ações
            max = 0; % Valor correspondente ao "max SOMATÓRIO[P(s'|s,a) * U[s']]" da equação de Bellman.            
            for a = 1:MDP.A  % Iteração sobre cada ação de "A". O objetivo deste loop é obter
                %fprintf('\n Estado: %d',s);
                %fprintf('\n Ação: %d',a);
                             % o valor máximo de "SOMATÓRIO[P(s'|s,a) * U[s']]".
                probabilidades_SA = MDP.T{1,a,1}(s,:); % Probabilidades de transição de "s" para todo "s'" dado "a":
                                                       % Retorna "s'" e probablidades em vetor 1 x |MDP.S|
                estadosDestino = find(probabilidades_SA); % Vetor de estados de destino "s'" a partir de "s". Retorna somente
                                                          % estados de destino em que a probabilidade de transição é não nula.
                probabilidades_SA = probabilidades_SA(probabilidades_SA ~= 0); % Vetor probabilidades_SA com valores não nulos.
                valor_PU = probabilidades_SA * U(estadosDestino); % Obtenção de "P(s'|s,a) * U[s']" para a ação "a" desde o estado "s"
                if valor_PU > max % Obtenção do "max".
                    max = valor_PU;
                    % a_max = a; % Ação correspondente ao "max" encontrado. IGNORAR. EM CONSTRUÇÃO.
                end
            end            
            % /Ações
            U_linha(s) = MDP.R(s, PoliticaProposta(s)) + (gama * max)';
            %fprintf('\n Máxima Utilidade: %d', U_linha(s));         
        end 
    dif = abs(U_linha(s) - U(s)); % Valor de "|U'[s] - U[s]|".
    U = U_linha;
    %if dif <= erro % verifica se a Politica gerou melhorias
     %   break;
    %end     
      
    end    
  
    % Passo 3 (melhoria da política), resolução arg max para cada estado
    for s = 1:MDP.S
        fprintf('\n Atualização de Política. Estado: %d',s);        
            % Ações
            max = 0; % Valor correspondente ao "max SOMATÓRIO[P(s'|s,a) * U[s']]" da equação de Bellman.            
            action = 1;
            for a = 1:MDP.A  % Iteração sobre cada ação de "A". O objetivo deste loop é obter
                             % o valor máximo de "SOMATÓRIO[P(s'|s,a) * U[s']]".
                probabilidades_SA = MDP.T{1,a,1}(s,:); % Probabilidades de transição de "s" para todo "s'" dado "a":
                                                       % Retorna "s'" e probablidades em vetor 1 x |MDP.S|
                estadosDestino = find(probabilidades_SA); % Vetor de estados de destino "s'" a partir de "s". Retorna somente
                                                          % estados de destino em que a probabilidade de transição é não nula.
                probabilidades_SA = probabilidades_SA(probabilidades_SA ~= 0); % Vetor probabilidades_SA com valores não nulos.
                valor_PU = probabilidades_SA * U_linha(estadosDestino); % Obtenção de "P(s'|s,a) * U[s']" para a ação "a" desde o estado "s"
                if valor_PU > max % Obtenção do "max".
                    max = valor_PU;
                    action = a;
                    % a_max = a; % Ação correspondente ao "max" encontrado. IGNORAR. EM CONSTRUÇÃO.
                end
            PoliticaProposta(s) = action;                
            end            
            % /Ações        
    end
    
end
    fprintf('\n Politica ótima:');           
for s = 1:MDP.S
    fprintf('\n Estado: %d', s);           
    fprintf('\n Ação: %d', PoliticaProposta(s));           
    fprintf('\n');    

end    
    PoliticaOtima = PoliticaProposta;
U = U_linha;
    termino = datetime('now')
end



