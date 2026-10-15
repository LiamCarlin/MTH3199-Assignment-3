function test_integration_stability(h_ref)
    figure('Color','w','Position',[100 50 1150 1250]);

    step_funcs = {@forward_euler_step, @backward_euler_step, ...
        @explicit_midpoint_step, @implicit_midpoint_step};

    names = {'Forward Euler','Backward Euler', ...
        'Explicit Midpoint','Implicit Midpoint'};

    colors = {'r','m','b','k'};

    tspan = [0,20];
    func = @(t,X) -5*X + 5*cos(t) - sin(t);
    t = linspace(tspan(1),tspan(2),2000);

    for i = 1:4
        subplot(4,1,i);

        [t_list,X_list,h,~] = fixed_step_integration( ...
            func,step_funcs{i},tspan,1,h_ref);

        plot(t,cos(t),'k-','LineWidth',2, ...
            'DisplayName','Analytical solution');
        hold on

        plot(t_list,X_list,'o--','Color',colors{i}, ...
            'LineWidth',1.5,'MarkerSize',4, ...
            'DisplayName',sprintf('Numerical, $h = %.4f$',h));

        title(names{i},'Interpreter','latex','FontSize',20);
        xlabel('Time, $t$ (-)', ...
            'Interpreter','latex','FontSize',18);
        ylabel('Solution, $x(t)$ (-)', ...
            'Interpreter','latex','FontSize',18);

        set(gca,'FontSize',16,'TickLabelInterpreter','latex');

        legend('Interpreter','latex','FontSize',14, ...
            'Location','eastoutside');

        xlim(tspan);
        grid on
        box on
        hold off
    end

    sgtitle(sprintf('Integration Stability: $h_{\\mathrm{ref}} = %.2f$',h_ref), ...
        'Interpreter','latex','FontSize',22);

    filename = sprintf('integration_stability_%.2f.png',h_ref);
    exportgraphics(gcf,filename,'Resolution',600);
end