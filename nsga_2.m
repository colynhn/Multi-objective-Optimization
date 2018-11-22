function nsga_2(pop,gen,tasknum0,nodenum0)

%% function nsga_2(pop,gen，tasknum0,nodenum0) 
% pop - 种群数量
% gen - 遗传代数
% tasknum0 - 任务个数
% nodenum0 - 节点
tic;
%% 错误检查 
if nargin < 4  
    error('NSGA-II: Please enter the population size and number of generations as input arguments.');
end

if isnumeric(pop) == 0 || isnumeric(gen) == 0 || isnumeric(tasknum0) == 0 || isnumeric(nodenum0) == 0   %判断输入的是一个数
    error('Both input arguments pop、gen、tasknum and nodenum should be integer datatype');
end

if pop < 20
    error('Minimum population for running this function is 20');
end
if gen < 5
    error('Minimum number of generations is 5');
end
if tasknum0 < 50 || tasknum0 > 250
    error('Minimum number of task is 50 and Maximum number of task is 250');
end
if nodenum0 > 15 || nodenum0 < 5 
    error('Minimum number of node is 5 and Maximum number of node is 15');
end
%  分别对其进行取整处
pop = round(pop);  
gen = round(gen);
tasknum = round(tasknum0);
nodenum = round(nodenum0);
%% Objective Function

[M, V, min_range, max_range] = objective_description_function(tasknum,nodenum);

%% Initialize the population

chromosome = initialize_variables(pop, M, V, min_range, max_range, tasknum, nodenum);


%% Sort the initialized population
%返回两列，一列代表rank，一列代表拥挤距离，然后追加在每一个染色体向量后边
chromosome = non_domination_sort_mod(chromosome, M, V);

%% Start the evolution process

for i = 1 : gen   % 代数，比说50代
   
    pool = round(pop/2);
    tour = 2;
  
    parent_chromosome = tournament_selection(chromosome, pool, tour); 
    % 染色体向量的最后两个元素被用到，第一个是rank值，第二个是拥挤距离
    %选出了父代染色体，一共10个，按照rank等级和相同rank等级的拥挤距离进行二进制锦标赛选择的结果
   
    mu = 20;  %% 交叉指数，即 ηc 
    mum = 20; %% 变异指数，即 ηm
    offspring_chromosome = ...
        genetic_operator(parent_chromosome, ...
        M, V, mu, mum, min_range, max_range, nodenum);

   %连接所选父代和交叉变异后子代 
    [main_pop,temp] = size(chromosome); %返回总的染色体几行几列
    [offspring_pop,temp] = size(offspring_chromosome); % 返回子代染色体几行几列
   
    clear temp
 
    intermediate_chromosome(1:main_pop,:) = chromosome;
    intermediate_chromosome(main_pop + 1 : main_pop + offspring_pop,1 : M+V) = ...
        offspring_chromosome;    %M 目标函数    V决策变量
 
   
    intermediate_chromosome = ...
        non_domination_sort_mod(intermediate_chromosome, M, V); 
    % Perform Selection
    %下面函数就是进行精英策略的使用
    chromosome = replace_chromosome(intermediate_chromosome, M, V, pop); 
    %if ~mod(i,100)  %%每100代提示一侧运行的完成情况
        %clc
        %fprintf('%d generations completed\n',i);
    %end
end

   t = toc;
   
   fprintf('程序运行时间为：%d\n',t);

%% Result

save solution.txt chromosome -ASCII

%% Visualize

if M == 2
    plot(chromosome(:,V + 1),chromosome(:,V + 2),'*');
     xlabel('任务总体完成时间');ylabel('负载均衡值');
end

    
