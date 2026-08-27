% HOMEWORK 1 %
% Sierra Martinez %
% Due date: 9/1/2026 %

% Variables %
x_nodes = 81; %number of nodes in x direction%
y_nodes = 81; %number of nodes in y direction%
x_dist = 2; %distance of interest in x direction%
y_dist = 2; %distance of interest in y direction%
u_x = 0.8;
u_y = 0.8;
v = 0.01;
t_total = 10; %not sure yet%
delta_t = 0.1; %time step, TBD%
i = 1; %x index (column)%
j = 1; %y index (row)%
t = 1; %t index%

% Set Up Grid %
frames = t_total / delta_t; %find number of time steps%
phi = zeros(x_nodes,y_nodes,frames); %defined empty 81x81 grid with third dimension for time

% Assign Initial Condition %

function initial_condition = init_state(x,y,v)          % Function that defines the initial conditions of all x,y coordinates %
    initial_condition = exp(-(x-0.5)^2/v - (y-0.5)^2/2);
end

for i = 1:x_nodes                                       % Iterate through t = 1 (actual value 0) to determine starting values %
    for j = 1:y_nodes
        if i == 1
            phi(i,j,t) = bc(); %I know I don't have to do it this way for this problem but I want to just to practice for the scenario where there's more complex bc%
        elseif i == i_nodes
            phi(i,j,t) = bc(); 
        elseif j == 1
            phi(i,j,t) = bc();
        elseif j == y_nodes
            phi(i,j,t) = bc();
        else
            x = x_dist * (i - 1);
            y = y_dist * (j - 1);
            phi(i,j,t) = init_state(x,y,v);
        end
    end
end

% Boundary Conditions %

function bound_cond = bc(~)
    bound_cond = 0;
end

