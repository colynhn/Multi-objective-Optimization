function f = initialize_variables(N, M, V, min_range, max_range, tasknum, nodenum)

%% function f = initialize_variables(N, M, V, min_tange, max_range) 
%初始化染色体

% N - 种群大小
% M - 目标函数数量
% V - 决策变量数量
% min_range 
% max_range 

min = min_range;
max = max_range;
taskn = tasknum;
noden = nodenum;



K = M + V;    %  决策变量 + 目标函数值

%% Initialize each chromosome   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%初始化每条染色体（基因，可能需要修改的地方）
% For each chromosome perform the following (N is the population size)
for i = 1 : N %种群大小
    
    s = 0;
    s0 = 0;
    
    for j = 1 : noden %节点多少（也就是k值的个数：决定分配给j个节点多少个任务）
        g(i,j) = min(j) + round((max(j) - min(j))*rand(1));
        s = s + g(i,j);
    end
    
    for j = 1 : noden
        f(i,j) = floor((g(i,j) * taskn ) / s);
        s0 = s0 + f(i,j);
    end
    if s0 ~= taskn
        f(i,noden) = f(i, noden) + taskn - s0;%%
    end
    
 
    for j = noden + 1 : V
        f(i,j) = min(j) + round((max(j) - min(j))*rand(1));
    end 
    
    % f(i,:)取出第一行数据    f(i,V+1:K) 
    f(i,V + 1: K) = evaluate_objective(f(i,:), M, V, noden);  
    
end
