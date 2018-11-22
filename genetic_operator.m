function f  = genetic_operator(parent_chromosome, M, V, mu, mum, l_limit, u_limit, nodenum)

%% function f  = genetic_operator(parent_chromosome, M, V, mu, mum, l_limit, u_limit)

% （遗传算子是用来产生后代的）

% parent_chromosome -（被选择的10个父代，用于产生子代）
% M - 目标函数个数
% V - 决策变量个数
% mu - 交叉分布指数
% mum - 变异分布指数
% l_limit - a vector of lower limit for the corresponding decsion variables
%
% u_limit - a vector of upper limit for the corresponding decsion variables
%
%遗传算子仅仅是操作决策变量


[N,m] = size(parent_chromosome);

clear m
p = 1;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Flags used to set if crossover and mutation were actually performed. 
was_crossover = 0;
was_mutation = 0;


for i = 1 : N %%%%对于种群中所选父代的10个个体中
    % With 90 % probability perform crossover （交叉的概率是0.9）
    if rand(1) < 0.9
        % Initialize the children to be null vector.
        child_1 = [];
        child_2 = [];
        % Select the first parent
        parent_1 = round(N*rand(1));
        if parent_1 < 1
            parent_1 = 1;
        end
        % Select the second parent
        parent_2 = round(N*rand(1));
        if parent_2 < 1
            parent_2 = 1;
        end         %%%在10个父代种群中选了2个父代，准备产生子代
        % Make sure both the parents are not the same. 
        while isequal(parent_chromosome(parent_1,:),parent_chromosome(parent_2,:))
            parent_2 = round(N*rand(1));
            if parent_2 < 1
                parent_2 = 1;
            end
        end
        % Get the chromosome information for each randomnly selected
        % parents
        parent_1 = parent_chromosome(parent_1,:);
        parent_2 = parent_chromosome(parent_2,:);  %%%取出两个所选父代的所以信息，包括决策变量，函数值，rank值以及distance值
        % Perform corssover for each decision variable in the chromosome.
        % 对于染色体中的决策变量，开始进行交叉
        for j = 1 : V %%决策变量数1到20
            % SBX (Simulated Binary Crossover).
            % For more information about SBX refer the enclosed pdf file.
            % Generate a random number
            u(j) = rand(1);
            if u(j) <= 0.5
                bq(j) = (2*u(j))^(1/(mu+1));
            else
                bq(j) = (1/(2*(1 - u(j))))^(1/(mu+1));
            end
            % Generate the jth element of first child 产生第一个孩子的第一个元素
            %%也就是对父代两个个体的第一个决策变量进行交叉，产生第一个子代的第一个决策变量
            child_1(j) = ...
                round(0.5*(((1 + bq(j))*parent_1(j)) + (1 - bq(j))*parent_2(j)));
            
            % Generate the jth element of second child
            child_2(j) = ...
                round(0.5*(((1 - bq(j))*parent_1(j)) + (1 + bq(j))*parent_2(j)));
            % Make sure that the generated element is within the specified
            % decision space else set it to the appropriate extrema.
            %%确保产生的决策变量的值不会超过预置的范围。
            if child_1(j) > u_limit(j)
                child_1(j) = u_limit(j);
            elseif child_1(j) < l_limit(j)
                child_1(j) = l_limit(j);
            end
            if child_2(j) > u_limit(j)
                child_2(j) = u_limit(j);
            elseif child_2(j) < l_limit(j)
                child_2(j) = l_limit(j);
            end
        end
        % Evaluate the objective function for the offsprings and as before
        % concatenate the offspring chromosome with objective value.
        child_1(:,V + 1: M + V) = evaluate_objective(child_1, M, V, nodenum);
        child_2(:,V + 1: M + V) = evaluate_objective(child_2, M, V, nodenum);
        % Set the crossover flag. When crossover is performed two children
        % are generate, while when mutation is performed only only child is
        % generated. 两根子代个体已经产生，
        was_crossover = 1;
        was_mutation = 0;
    % With 10 % probability perform mutation. Mutation is based on
    % polynomial mutation. 
    else
        % Select at random the parent.
        parent_3 = round(N*rand(1));
        if parent_3 < 1
            parent_3 = 1;
        end
        % Get the chromosome information for the randomnly selected parent.
        child_3 = parent_chromosome(parent_3,:);
        % Perform mutation on eact element of the selected parent.
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%接下继续修改
        for j = 1 : V %%%%对于所有的决策变量
           r(j) = rand(1);
           if r(j) < 0.5
               delta(j) = (2*r(j))^(1/(mum+1)) - 1;
           else
               delta(j) = 1 - (2*(1 - r(j)))^(1/(mum+1));
           end
           % Generate the corresponding child element.
           child_3(j) = child_3(j) + round(delta(j));
           % Make sure that the generated element is within the decision
           % space.
           if child_3(j) > u_limit(j)
               child_3(j) = u_limit(j);
           elseif child_3(j) < l_limit(j)
               child_3(j) = l_limit(j);
           end
        end
        % Evaluate the objective function for the offspring and as before
        % concatenate the offspring chromosome with objective value.    
        child_3(:,V + 1: M + V) = evaluate_objective(child_3, M, V, nodenum);
        % Set the mutation flag
        was_mutation = 1;
        was_crossover = 0;
    end
    % Keep proper count and appropriately fill the child variable with all
    % the generated children for the particular generation.
    if was_crossover
        child(p,:) = child_1;
        child(p+1,:) = child_2;
        was_cossover = 0;
        p = p + 2;
    elseif was_mutation
        child(p,:) = child_3(1,1 : M + V);
        was_mutation = 0;
        p = p + 1;
    end
end
f = child;
