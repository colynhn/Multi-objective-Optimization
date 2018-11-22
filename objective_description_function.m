function [number_of_objectives, number_of_decision_variables, min_range_of_decesion_variable, max_range_of_decesion_variable] = objective_description_function(tasknum,nodenum)
%% 初始化决策变量范围
g = sprintf('Input the number of objective: ');

number_of_objectives = input(g);
if number_of_objectives < 2
    error('This is a multi-objective optimization function hence the minimum number of objectives is two');
end

number_of_decision_variables = nodenum + nodenum;

clc

%g = sprintf('\nInput the minimum value for decision variable 1 : ');
%min_range_of_decesion_variable(1) = input(g);
%g = sprintf('\nInput the maximum value for decision variable 1 (equal to the number of tasknum): ');
%if input(g) ~= tasknum
    %error('please input the number that equals to tasknum');
%end
%max_range_of_decesion_variable(1) = input(g);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 最小值
for i = 1: nodenum
    min_range_of_decesion_variable(i) = round(tasknum/nodenum) - 3;
end

%最大值
for i = 1: nodenum
    max_range_of_decesion_variable(i) = round(tasknum/nodenum) + 3;
end

g = sprintf('\nInput the minimum value for decision variable nodenum + 1  --- number_of_decision_variables : ');
a = input(g);
for i = nodenum + 1: number_of_decision_variables
    %clc
    %g = sprintf('\nInput the minimum value for decision variable %d : ', i);
    % Obtain the minimum possible value for each decision variable
    min_range_of_decesion_variable(i) = a;
    %g = sprintf('\nInput the maximum value for decision variable %d : ', i);
    % Obtain the maximum possible value for each decision variable
   %max_range_of_decesion_variable(i) = input(g);
    %clc
end

g = sprintf('\nInput the maximum value for decision variable nodenum + 1 --- number_of_decision_variables :');
a = input(g);
for i = nodenum + 1: number_of_decision_variables
    max_range_of_decesion_variable(i) = a;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for i = 1: number_of_decision_variables
    %clc
    %g = sprintf('\nInput the minimum value for decision variable %d : ', i);
    % Obtain the minimum possible value for each decision variable
    %min_range_of_decesion_variable(i) = input(g);
    %g = sprintf('\nInput the maximum value for decision variable %d : ', i);
    % Obtain the maximum possible value for each decision variable
%max_range_of_decesion_variable(i) = input(g);
    %clc
%end
g = sprintf('\n Now edit the function named "evaluate_objective" appropriately to match your needs.\n Make sure that the number of objective functions and decision variables match your numerical input. \n Make each objective function as a corresponding array element. \n After editing do not forget to save. \n Press "c" and enter to continue... ');
% Prompt the user to edit the evaluate_objective function and wait until
% 'c' is pressed.
x = input(g, 's'); % 将输入的值作为字符来处理。
if isempty(x)
    x = 'x';
end
while x ~= 'c'
    clc
    x = input(g, 's');
    if isempty(x)
        x = 'x';
    end
end    
