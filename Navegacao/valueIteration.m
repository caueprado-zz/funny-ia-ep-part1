function Politica = valueIteration(MDP, gama, erro)
    % U_linha: vetor de utilidade para estados em "S", inicialmente zero. Registra a utilidade na itera��o "i".
    % U: vetor de utilidade para estados em "S", inicialmente zero. Registra a utilidade na itera��o "i-1".
    % delta: mudan�a m�xima na utilidade de qualquer estado em uma itera��o.
    % gama: fator de desconto.
    % epsilon: erro m�ximo permitido na utilidade de qualquer estado.
    % Condi��o de parada: a atualiza��o de Bellman termina quando a diferen�a entre "U_linha" e "U" for menor que
    %                     "epsilon * (1-gama)/gama" (conforme algoritmo do Norvig (figura 17.4).
    
    % Inicializa��es
    
    inicio = datetime('now')
    
    U_linha = zeros (MDP.S,1); % Cria��o de um vetor com "S" linhas e "1" coluna e inicializa��o com zeros.
    epsilon = erro; % Inicializa��o de "epsilon" com o valor passado como par�metro para esta fun��o.
    delta = 0;

    %while ( delta < epsilon * (1 - gama)/gama ) % Condi��o de parada.
    for i=1:300
        U = U_linha;
        for s = 1:MDP.S % Itera��o sobre cada estado de "S".
            max = 0; % Valor correspondente ao "max SOMAT�RIO[P(s'|s,a) * U[s']]" da equa��o de Bellman.
            for a = 1:MDP.A  % Itera��o sobre cada a��o de "A". O objetivo deste loop � obter
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
            U_linha(s) = MDP.R(s) + gama * max; % Atualiza��o de Bellman.
            diff_UUlinha = abs(U_linha(s) - U(s)); % Valor de "|U'[s] - U[s]|".
            if diff_UUlinha > delta
                delta = diff_UUlinha;
            end
        end
    end
    U_linha
    
    termino = datetime('now')
end

