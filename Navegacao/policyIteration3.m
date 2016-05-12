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
        % Passo 2 -  (avalia��o da pol�tica)
        fprintf('\n Avalia��o de Pol�tica. Itera��o: %d',i);
        for s = 1:MDP.S       
            % A��es
            max = 0; % Valor correspondente ao "max SOMAT�RIO[P(s'|s,a) * U[s']]" da equa��o de Bellman.            
            for a = 1:MDP.A  % Itera��o sobre cada a��o de "A". O objetivo deste loop � obter
                %fprintf('\n Estado: %d',s);
                %fprintf('\n A��o: %d',a);
                             % o valor m�ximo de "SOMAT�RIO[P(s'|s,a) * U[s']]".
                probabilidades_SA = MDP.T{1,a,1}(s,:); % Probabilidades de transi��o de "s" para todo "s'" dado "a":
                                                       % Retorna "s'" e probablidades em vetor 1 x |MDP.S|
                estadosDestino = find(probabilidades_SA); % Vetor de estados de destino "s'" a partir de "s". Retorna somente
                                                          % estados de destino em que a probabilidade de transi��o � n�o nula.
                probabilidades_SA = probabilidades_SA(probabilidades_SA ~= 0); % Vetor probabilidades_SA com valores n�o nulos.
                valor_PU = probabilidades_SA * U(estadosDestino); % Obten��o de "P(s'|s,a) * U[s']" para a a��o "a" desde o estado "s"
                if valor_PU > max % Obten��o do "max".
                    max = valor_PU;
                    % a_max = a; % A��o correspondente ao "max" encontrado. IGNORAR. EM CONSTRU��O.
                end
            end            
            % /A��es
            U_linha(s) = MDP.R(s, PoliticaProposta(s)) + (gama * max)';
            %fprintf('\n M�xima Utilidade: %d', U_linha(s));         
        end 
    dif = abs(U_linha(s) - U(s)); % Valor de "|U'[s] - U[s]|".
    U = U_linha;
    %if dif <= erro % verifica se a Politica gerou melhorias
     %   break;
    %end     
      
    end    
  
    % Passo 3 (melhoria da pol�tica), resolu��o arg max para cada estado
    for s = 1:MDP.S
        fprintf('\n Atualiza��o de Pol�tica. Estado: %d',s);        
            % A��es
            max = 0; % Valor correspondente ao "max SOMAT�RIO[P(s'|s,a) * U[s']]" da equa��o de Bellman.            
            action = 1;
            for a = 1:MDP.A  % Itera��o sobre cada a��o de "A". O objetivo deste loop � obter
                             % o valor m�ximo de "SOMAT�RIO[P(s'|s,a) * U[s']]".
                probabilidades_SA = MDP.T{1,a,1}(s,:); % Probabilidades de transi��o de "s" para todo "s'" dado "a":
                                                       % Retorna "s'" e probablidades em vetor 1 x |MDP.S|
                estadosDestino = find(probabilidades_SA); % Vetor de estados de destino "s'" a partir de "s". Retorna somente
                                                          % estados de destino em que a probabilidade de transi��o � n�o nula.
                probabilidades_SA = probabilidades_SA(probabilidades_SA ~= 0); % Vetor probabilidades_SA com valores n�o nulos.
                valor_PU = probabilidades_SA * U_linha(estadosDestino); % Obten��o de "P(s'|s,a) * U[s']" para a a��o "a" desde o estado "s"
                if valor_PU > max % Obten��o do "max".
                    max = valor_PU;
                    action = a;
                    % a_max = a; % A��o correspondente ao "max" encontrado. IGNORAR. EM CONSTRU��O.
                end
            PoliticaProposta(s) = action;                
            end            
            % /A��es        
    end
    
end
    fprintf('\n Politica �tima:');           
for s = 1:MDP.S
    fprintf('\n Estado: %d', s);           
    fprintf('\n A��o: %d', PoliticaProposta(s));           
    fprintf('\n');    

end    
    PoliticaOtima = PoliticaProposta;
U = U_linha;
    termino = datetime('now')
end



