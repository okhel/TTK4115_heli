function plotResults()
    clc;

    disp('Loading data...');
    data = struct();

    data.crit_damped = struct();
    data.crit_damped.test1 = load('results/results_(-1,-1).mat');
    data.crit_damped.test2 = load('results/results_(-2,-2).mat');
    data.crit_damped.test3 = load('results/results_(-5,-5).mat');

    data.over_damped = struct();
    data.over_damped.test1 = load('results/results_(-5,-1).mat');

    data.under_damped = struct();
    data.under_damped.test1 = load('results/results_(-1+5i,-1-5i).mat');
    data.under_damped.test2 = load('results/results_(-5+5i,-5-5i).mat');
    data.under_damped.test3 = load('results/results_(-5+i,-5-i).mat');
    data.under_damped.test4 = load('results/results_(0,-1).mat');

    %% Processing
    t = data.crit_damped.test1.ans(1,:);
    idx_first_30 = find(t == 30, 1, 'first');

    t = t(1:idx_first_30);
    p_c = data.crit_damped.test1.ans(2,1:idx_first_30);
    
    for i = 1:size(data.crit_damped, 1)
        if (~isequal(data.crit_damped(i).test1.ans(2,1:idx_first_30), p_c))
            disp(['Reference is not identical for critically damped test', num2str(i)]);
        end
    end

    for i = 1:size(data.over_damped, 1)
        if (~isequal(data.over_damped(i).test1.ans(2,1:idx_first_30), p_c))
            disp(['Reference is not identical for overdamped test', num2str(i)]);
        end
    end

    for i = 1:size(data.under_damped, 1)
        if (~isequal(data.under_damped(i).test1.ans(2,1:idx_first_30), p_c))
            disp(['Reference is not identical for underdamped test', num2str(i)]);
        end
    end

    %% Critically damped

    disp('Plotting critically damped...');

    figure(1); clf; hold on; grid on;
    p1 = data.crit_damped.test1.ans(3,1:idx_first_30);
    p2 = data.crit_damped.test2.ans(3,1:idx_first_30);
    p3 = data.crit_damped.test3.ans(3,1:idx_first_30);
    plot(t, p_c, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
    plot(t, p1, 'LineWidth', 2);
    plot(t, p2, 'LineWidth', 2);
    plot(t, p3, 'LineWidth', 2);
    legend('\lambda_1 = \lambda_2 = -1', '\lambda_1 = \lambda_2 = -2', '\lambda_1 = \lambda_2 = -5');
    xlabel('Time [s]');
    ylabel('Position [rad]');
    xlim([0, 30]);
    title('Critically Damped');

    %% Overdamped

    disp('Plotting overdamped...');
    
    figure(2); clf; hold on; grid on;
    p1 = data.over_damped.test1.ans(3,1:idx_first_30);
    plot(t, p_c, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
    plot(t, p1, 'LineWidth', 2);
    legend('\lambda_1 = -1, \lambda_2 = -5');
    xlabel('Time [s]');
    ylabel('Position [rad]');
    xlim([0, 30]);
    title('Overdamped');

    %% Underdamped

    disp('Plotting underdamped...');
    
    figure(3); clf; hold on; grid on;
    p1 = data.under_damped.test1.ans(3,1:idx_first_30);
    p2 = data.under_damped.test2.ans(3,1:idx_first_30);
    p3 = data.under_damped.test3.ans(3,1:idx_first_30);
    p4 = data.under_damped.test4.ans(3,:);
    t4 = data.under_damped.test4.ans(1,:);
    plot(t, p_c, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
    plot(t, p1, 'LineWidth', 2);
    plot(t, p2, 'LineWidth', 2);
    plot(t, p3, 'LineWidth', 2);
    plot(t4, p4, 'LineWidth', 2);
    legend('\lambda_1 = -1 + 5i, \lambda_2 = -1 - 5i', '\lambda_1 = -5 + 5i, \lambda_2 = -5 - 5i', '\lambda_1 = -5 + i, \lambda_2 = -5 - i', '\lambda_1 = 0, \lambda_2 = -1');

    disp('Done!');
end

