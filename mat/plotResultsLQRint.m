function plotResultsLQRint()
    clc;
    init_heli_3_10();

    disp('Loading data...');
    data = struct();

    % R as Id

    % Q as Id, scaling it 
    data.Q_scaled_Id = struct();
    data.Q_scaled_Id.test1 = load('results/part2/integral_lqr/results_(lqr_int_Id_Id).mat'); % Id
    data.Q_scaled_Id.test2 = load('results/part2/integral_lqr/results_(lqr_int_10_Id).mat'); % 10 Id
    data.Q_scaled_Id.test3 = load('results/part2/integral_lqr/results_(lqr_int_100_Id).mat'); % 100 Id
    
    % Q as 1Id, scaling x_4 = gamma
    data.punish_p = struct();
    data.punish_p.test1 = load('results/part2/integral_lqr/results_(lqr_int_Id_Id).mat'); % punish gamma: 1
    data.punish_p.test2 = load('results/part2/integral_lqr/results_(lqr_int_Id_gamma10_Id).mat'); % punish gamma: 10
    data.punish_p.test3 = load('results/part2/integral_lqr/results_(lqr_int_Id_gamma100_Id).mat'); % punish gamma: 100
    
    %% Processing
    t = data.Q_scaled_Id.test1.ans(1,:);
    idx_first_30 = find(t == 27, 1, 'first');

    t = t(1:idx_first_30);
    p_c = data.Q_scaled_Id.test1.ans(2,1:idx_first_30);
    
    % Tests that the reference is identical for each test
    for i = 1:size(data.Q_scaled_Id, 1)
        if (~isequal(data.Q_scaled_Id(i).test1.ans(2,1:idx_first_30), p_c))
            disp(['Reference is not identical for scaled Q Id test', num2str(i)]);
        end
    end
    for i = 1:size(data.punish_p, 1)
        if (~isequal(data.punish_p(i).test1.ans(2,1:idx_first_30), p_c))
            disp(['Reference is not identical for punish p test', num2str(i)]);
        end
    end

    %% Scaled Q Id matrix

    disp('Plotting scaled Q Id matrix...');

    figure(1); clf; hold on; grid on;
    p1 = data.Q_scaled_Id.test1.ans(3,1:idx_first_30);
    p2 = data.Q_scaled_Id.test2.ans(3,1:idx_first_30);
    p3 = data.Q_scaled_Id.test3.ans(3,1:idx_first_30);
    plot(t, p_c, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
    plot(t, p1, 'LineWidth', 3, 'Color', colors{1});
    plot(t, p2, 'LineWidth', 3, 'Color', colors{2});
    plot(t, p3, 'LineWidth', 3, 'Color', colors{3});
    legend({'Q = $\mathbb{I}_d$', 'Q = 10 $\mathbb{I}_d$', 'Q = 100 $\mathbb{I}_d$'}, 'Interpreter', 'latex');
    xlabel('Time [s]');
    ylabel('Position [rad]');
    xlim([0, 27]);
    ylim([-0.2, 0.6]);
    title('Scaled Q Id matrix', 'Interpreter', 'latex');

    %% Punish p in 10 Id matrix

    disp('Plotting punish gamma in Id matrix...');
    
    figure(2); clf; hold on; grid on;
    p1 = data.punish_p.test1.ans(3,1:idx_first_30);
    p2 = data.punish_p.test2.ans(3,1:idx_first_30);
    p3 = data.punish_p.test3.ans(3,1:idx_first_30);
    plot(t, p_c, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
    plot(t, p1, 'LineWidth', 3, 'Color', colors{1});
    plot(t, p2, 'LineWidth', 3, 'Color', colors{2});
    plot(t, p3, 'LineWidth', 3, 'Color', colors{3});
    legend({'Punish \gamma = 1', 'Punish \gamma = 10', 'Punish \gamma = 100'}, 'Interpreter', 'latex');
    xlabel('Time [s]');
    ylabel('Position [rad]');
    xlim([0, 27]);
    ylim([-0.2, 0.6]);
    title('Punish p in 10 Id matrix');

    disp('Done!');
end

