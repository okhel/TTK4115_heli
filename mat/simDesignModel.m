init_heli_3_10;

simMdl = 'DesignModel';  % Model name
load_system(simMdl);

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

plotResults();

hold on;  % Keep existing plots

lambdas = [-1, -2, -5];

figure(1)
lgd = legend().String;
for i = 1:3
    % Setting eigenvalues
    lambda_1 = lambdas(i);
    lambda_2 = lambdas(i);

    % Pitch PD-controller gains
    K_pp = -(lambda_1 + lambda_2) / K_1;
    K_pd = (lambda_1 * lambda_2) / K_1;

    % Run simulation
    disp('Running simulation...');
    Y = sim(simMdl);

    disp('Simulation complete.');

    plot(Y.simout, 'Color', colors{i}, 'LineWidth', 1)
    lgd(3+i) = {['\lambda_1 = \lambda_2 = ', num2str(lambdas(i)), ' (DM)']};
end
legend(lgd)
xlim([0, 30]);