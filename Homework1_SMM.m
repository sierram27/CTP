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
t_total = 1.0; %given in the results section of directions as the time to report on%
delta_t = 0.01; %time step, TBD%
i = 1; %x index (column)%
j = 1; %y index (row)%
t = 1; %t index%

% Set Up Grid %
frames = t_total / delta_t; %find number of time steps%
phi = zeros(x_nodes,y_nodes,frames); %defined empty 81x81 grid with third dimension for time
delta_x = x_dist / (x_nodes -1);
delta_y = y_dist / (y_nodes -1);

% Assign Initial Condition %

function initial_condition = init_state(x,y,v)          % Function that defines the initial conditions of all x,y coordinates %
    initial_condition = exp(-(x-0.5)^2/v - (y-0.5)^2/v);
end

for i = 1:x_nodes                                       % Iterate through t = 1 (actual value 0) to determine starting values %
    for j = 1:y_nodes
        x = delta_x * (i - 1);
        y = delta_y * (j - 1);
        phi(i,j,t) = init_state(x,y,v);
    end
end

% Boundary Conditions %

function bound_cond = bc(u_x,u_y,v,x,y,t)
    bound_cond = (1/(4*t+1)) * exp(- ((x-u_x*t-0.5)^2 + (y-u_y*t-0.5)^2) / (v*(4*t+1)) );
end

% Numerically Estimate %
i = 1;
j = 1;
t = 2;

function r_prev_time = R(u_x,u_y,v,delta_x,delta_y,center,left,right,up,down)
    r_prev_time = u_x*(right-left)/(2*delta_x) + u_y*(up-down)/(2*delta_y) - v*(right-2*center+left)/delta_x^2 - v*(up-2*center+down)/delta_y^2;
end

function estimate = phi_new(delta_t,current,r)
    estimate = current - delta_t * r;
end

for t = 2:frames
    for i = 1:x_nodes
        for j = 1:y_nodes
            x = delta_x * (i - 1);
            y = delta_y * (j - 1);
            t_real = delta_t * (t-1);
            if i == 1
                phi(i,j,t) = bc(u_x,u_y,v,x,y,t_real);
            elseif i == x_nodes
                phi(i,j,t) = bc(u_x,u_y,v,x,y,t_real);
            elseif j == 1
                phi(i,j,t) = bc(u_x,u_y,v,x,y,t_real);
            elseif j == y_nodes
                phi(i,j,t) = bc(u_x,u_y,v,x,y,t_real);
            else
                r = R(u_x,u_y,v,delta_x,delta_y,phi(i,j,t-1),phi(i-1,j,t-1),phi(i+1,j,t-1),phi(i,j+1,t-1),phi(i,j-1,t-1));
                phi(i,j,t) = phi_new(delta_t,phi(i,j,(t-1)),r);
            end
        end
    end
end


% Plot Initial Condition %
%surf(1:x_nodes,1:y_nodes,phi(1:x_nodes,1:y_nodes,1));

% Plot Final Condition %
surf(1:x_nodes,1:y_nodes,phi(1:x_nodes,1:y_nodes,frames));

% Plot Real Solution %