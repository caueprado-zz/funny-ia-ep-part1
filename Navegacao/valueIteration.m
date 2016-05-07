function Politica = valueIteration(MDP, gama, erro)
    % U_linha: vetor de utilidade para estados em "S", inicialmente zero. Registra a utilidade na iteração "i".
    % U: vetor de utilidade para estados em "S", inicialmente zero. Registra a utilidade na iteração "i-1".
    % delta: mudança máxima na utilidade de qualquer estado em uma iteração.
    % gama: fator de desconto.
    % epsilon: erro máximo permitido na utilidade de qualquer estado.
    % Condição de parada: a atualização de Bellman termina quando a diferença entre "U_linha" e "U" for menor que
    %                     "epsilon * (1-gama)/gama" (conforme algoritmo do Norvig (figura 17.4).
    
    % Inicializações
    
    inicio = datetime('now')
    
    U_linha = zeros (MDP.S,1); % Criação de um vetor com "S" linhas e "1" coluna e inicialização com zeros.
    epsilon = erro; % Inicialização de "epsilon" com o valor passado como parâmetro para esta função.
    delta = 0;

    %while ( delta < epsilon * (1 - gama)/gama ) % Condição de parada.
    for i=1:300
        U = U_linha;
        for s = 1:MDP.S % Iteração sobre cada estado de "S".
            max = 0; % Valor correspondente ao "max SOMATÓRIO[P(s'|s,a) * U[s']]" da equação de Bellman.
            for a = 1:MDP.A  % Iteração sobre cada ação de "A". O objetivo deste loop é obter
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
            U_linha(s) = MDP.R(s) + gama * max; % Atualização de Bellman.
            diff_UUlinha = abs(U_linha(s) - U(s)); % Valor de "|U'[s] - U[s]|".
            if diff_UUlinha > delta
                delta = diff_UUlinha;
            end
        end
    end
    U_linha
    
    termino = datetime('now')
end

