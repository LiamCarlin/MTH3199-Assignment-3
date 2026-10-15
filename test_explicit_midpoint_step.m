% Run with test_explicit_midpoint_step([0,10], 1, [0.01, 0.1, 0.45]), for some
% reason, like at href = 0.4 its still very accurate but at href = 0.5, it
% goes bananas. Do not know why, if someone can explain, be my guest.

function test_explicit_midpoint_step(tspan,X0,h_guess)
    figure('Color','w');
    t = linspace(tspan(1),tspan(2),1000);
    colors = {'r','b','m'};
    func = @(t,X) rate_func01(t,X);
    
    % Analytical solution
    plot(t,solution01(t),'k-','LineWidth',2, 'DisplayName','Analytical solution');
    hold on
    
    % Explicit midpoint steps
    for i = 1:length(h_guess)
        [t_list,X_list,h,~] = explicit_midpoint_step_integration(func,tspan,X0,h_guess(i));
    
        plot(t_list,X_list,'--','Color',colors{i}, 'LineWidth',1.5, 'DisplayName',sprintf('Midpoint, h = %.3f',h));
    end

    xlabel('Time, t (-)','Interpreter','latex');
    ylabel('Solution, x(t) (-)','Interpreter','latex');
    title('Explicit Midpoint vs Analytical Solution', 'Interpreter','latex');
    
    set(gca,'FontSize',16,'TickLabelInterpreter','latex');
    legend('Interpreter','latex','FontSize',14, 'Location','southoutside','NumColumns',2);
    
    xlim(tspan);
    grid on
    box on
    hold off
    
    exportgraphics(gcf,'explicit_midpoint_verification.png','Resolution',600);
end

function dXdt = rate_func01(t,X)
    dXdt = -5*X + 5*cos(t) - sin(t);
end

function X = solution01(t)
    X = cos(t);
end