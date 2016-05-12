function Politica = valueIteration3(MDP, gama, erro)
    % V_linha: vetor de utilidade para estados em "S", inicialmente zero. Registra a utilidade na itera��o "i".
    % V: vetor de utilidade para estados em "S", inicialmente zero. Registra a utilidade na itera��o "i-1".
    % delta: mudan�a m�xima na utilidade de qualquer estado em uma itera��o.
    % gama: fator de desconto.
    % epsilon: erro m�ximo permitido na utilidade de qualquer estado.
    % Condi��o de parada: a atualiza��o de Bellman termina quando a diferen�a entre "V_linha" e "V" for menor que
    %                     "epsilon * (1-gama)/gama" (conforme algoritmo do Norvig (figura 17.4).
    
    % Inicializa��es
    inicio = datetime('now');
    maxQ = zeros (MDP.S,1); % Cria��o de um vetor com "S" linhas e "1" coluna e inicializa��o com zeros.
    epsilon = erro; % Inicializa��o de "epsilon" com o valor passado como par�metro para esta fun��o.
    delta = 10000;
    iter = 0;

    while ( delta >= epsilon * (1 - gama)/gama ) % Condi��o de parada. *** %for i=1:50 ***
        iter = iter + 1;
        delta = 0;
        V = maxQ; % Equivalente a: para cada s de S, V(s)<-max[a de A]Q(s,a)
        for s = 1:MDP.S % Itera��o sobre cada estado de "S".
            for a = 1:MDP.A  % Itera��o sobre cada a��o de "A". O objetivo deste loop � obter o valor de m�ximo de Q (maxQ).
                Q(s,a) = MDP.R(s,a) + gama * (MDP.T{1,a,1}(s,:) * V); % Obten��o de "r(s,a) + gama * (P(s'|s,a) * V[s'])".                
            end
            maxQ(s) = max(Q(s,:)); % Identifica e recupera o melhor valor de utilidade para o estado 's' dentre todas as a��es.
            delta = max(delta, abs(maxQ(s) - V(s))); % Atualiza��o de delta com o maior valor dentre "delta atual" e a utilidade em "s".
        end
        Q_TOTAL(iter,:) = maxQ';
    end
        
    inicio
    termino = datetime('now')
    delta
    iter
    csvwrite('Q_TOTAL.csv', Q_TOTAL);
end