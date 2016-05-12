function Politica = valueIteration3(MDP, gama, erro)
    % V_linha: vetor de utilidade para estados em "S", inicialmente zero. Registra a utilidade na iteração "i".
    % V: vetor de utilidade para estados em "S", inicialmente zero. Registra a utilidade na iteração "i-1".
    % delta: mudança máxima na utilidade de qualquer estado em uma iteração.
    % gama: fator de desconto.
    % epsilon: erro máximo permitido na utilidade de qualquer estado.
    % Condição de parada: a atualização de Bellman termina quando a diferença entre "V_linha" e "V" for menor que
    %                     "epsilon * (1-gama)/gama" (conforme algoritmo do Norvig (figura 17.4).
    
    % Inicializações
    inicio = datetime('now');
    maxQ = zeros (MDP.S,1); % Criação de um vetor com "S" linhas e "1" coluna e inicialização com zeros.
    epsilon = erro; % Inicialização de "epsilon" com o valor passado como parâmetro para esta função.
    delta = 10000;
    iter = 0;

    while ( delta >= epsilon * (1 - gama)/gama ) % Condição de parada. *** %for i=1:50 ***
        iter = iter + 1;
        delta = 0;
        V = maxQ; % Equivalente a: para cada s de S, V(s)<-max[a de A]Q(s,a)
        for s = 1:MDP.S % Iteração sobre cada estado de "S".
            for a = 1:MDP.A  % Iteração sobre cada ação de "A". O objetivo deste loop é obter o valor de máximo de Q (maxQ).
                Q(s,a) = MDP.R(s,a) + gama * (MDP.T{1,a,1}(s,:) * V); % Obtenção de "r(s,a) + gama * (P(s'|s,a) * V[s'])".                
            end
            maxQ(s) = max(Q(s,:)); % Identifica e recupera o melhor valor de utilidade para o estado 's' dentre todas as ações.
            delta = max(delta, abs(maxQ(s) - V(s))); % Atualização de delta com o maior valor dentre "delta atual" e a utilidade em "s".
        end
        Q_TOTAL(iter,:) = maxQ';
    end
        
    inicio
    termino = datetime('now')
    delta
    iter
    csvwrite('Q_TOTAL.csv', Q_TOTAL);
end