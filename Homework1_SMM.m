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
delta_t = 0.1; %time step, TBD %
i = 1; %x index (column)%
j = 1: %y index (row)%
t = 1; %t index%

% Set Up Grid %
frames = t_total / delta_t; %find number of time steps%
phi = double.empty(x_nodes,y_nodes,frames); %defined empty 81x81 grid with third dimension for time

% Assign Initial Condition %
for i = 1:x_nodes
    for j = 1:y_nodes
        if i == 1
            %send through boundary conditions
        elseif i == i_nodes
            %send through boundary conditions
        elseif j == 1
            %send through boundary conditions
        elseif j == y_nodes
            %send through boundary conditions
        else
            phi(i,j,t) = init_state(i,j,v);
        end
    end
end

function initial_condition = init_state(x,y,v)
   initial_condition = exp(-(x-0.5)^2/v - (y-0.5)^2/2);
end

% Boundary Conditions %

