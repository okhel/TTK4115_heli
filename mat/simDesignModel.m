%% Initialization
clear;clc;
init_heli_3_10;

%% Plot experimentalresults
plotResults();


%% Initialize simulation model
simMdl = 'DesignModel';  % Model name
load_system(simMdl);

disp('Initializing simulation model...');
t_end = 35;
dt_sim = 0.01;
% Configure simulation parameters
set_param(simMdl, ...
    'Solver', 'ode45', ...           % Variable-step solver
    'SimulationMode', 'normal', ...
    'StopTime', 't_end', ...
    'RelTol', '1e-3', ...           % Relative tolerance
    'AbsTol', '1e-6', ...           % Absolute tolerance
    'MaxStep', 'dt_sim', ...        % Maximum step size
    'ReturnWorkspaceOutputs', 'on')


%% Simulate design model for critically damped

% zeta = 1
lambdas = [-1, -2, -4];
figure(1)
lgd = legend().String;
n = size(lgd,2);
for i = 1:3
    % Setting eigenvalues
    lambda_1 = lambdas(i);
    lambda_2 = lambdas(i);

    % Pitch PD-controller gains
    K_pd = -(lambda_1 + lambda_2) / K_1;
    K_pp = (lambda_1 * lambda_2) / K_1;

    % Run simulation
    disp('Running simulation...');
    Y = sim(simMdl);

    disp('Simulation complete.');

    plot(Y.simout, 'Color', colors{i}, 'LineWidth', 1)
    lgd(n+i) = {['\lambda_1 = \lambda_2 = ', num2str(lambdas(i)), ' (DM)']};
end
legend(lgd)
xlim([0, 30]);


%% Simulate design model for overdamped

% zeta = 1, 2, 4
lambdas = {[-2, -2], [-4, -1], [-8, -0.5]};
figure(2)
lgd = legend().String;
n = size(lgd,2);
for i = 1:3
    % Setting eigenvalues
    lambda_1 = lambdas{i}(1);
    lambda_2 = lambdas{i}(2);

    % Pitch PD-controller gains
    K_pd = -(lambda_1 + lambda_2) / K_1;
    K_pp = (lambda_1 * lambda_2) / K_1;

    % Run simulation
    disp('Running simulation...');
    Y = sim(simMdl);

    disp('Simulation complete.');

    plot(Y.simout, 'Color', colors{i}, 'LineWidth', 1)
    lgd(n+i) = {['\lambda_1 = ', num2str(lambdas{i}(1)), '\lambda_2 = ', num2str(lambdas{i}(2)), ' (DM)']};
end
legend(lgd)
xlim([0, 30]);

%% Simulate design model for underdamped

% zeta = 
lambdas = {[-1+0.5i, -1-0.5i], [-1+1i, -1-1i], [-1+1.5i, -1-1.5i]};
lambdas_text = {'-1 \pm 0.5i', '-1 \pm 1i', '-1 \pm 1.5i'};

figure(3)
lgd = legend().String;
n = size(lgd,2);
for i = 1:3
    % Setting eigenvalues
    lambda_1 = lambdas{i}(1);
    lambda_2 = lambdas{i}(2);

    % Pitch PD-controller gains
    K_pd = -(lambda_1 + lambda_2) / K_1;
    K_pp = (lambda_1 * lambda_2) / K_1;

    % Run simulation
    disp('Running simulation...');
    Y = sim(simMdl);

    disp('Simulation complete.');

    plot(Y.simout, 'Color', colors{i}, 'LineWidth', 1)
    lgd(n+i) = {['\lambda_1, \lambda_2 = ', lambdas_text{i}, ' (DM)']};
end
legend(lgd)
xlim([0, 30]);