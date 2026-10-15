function test_integration_stability(h_ref)
    figure('Color','w','Position',[100 50 900 1000]);
    
    step_funcs = {@forward_euler_step, @backward_euler_step, @explicit_midpoint_step, @implicit_midpoint_step};
    
    names = {'Forward Euler','Backward Euler', 'Explicit Midpoint','Implicit Midpoint'};
    
    func = @(t,X) -5*X + 5*cos(t) - sin(t);
    t = linspace(0,20,2000);
    
    for i = 1:4
        subplot(4,1,i);
    
        [t_list,X_list,h,~] = fixed_step_integration(func,step_funcs{i},[0,20],1,h_ref);
    
        plot(t,cos(t),'k-','LineWidth',1.5, 'DisplayName','Analytical solution');
        hold on
    
        plot(t_list,X_list,'b--','LineWidth',1.5, 'DisplayName',sprintf('Numerical, h = %.3f',h));
    
        title(names{i},'Interpreter','latex');
        xlabel('Time, t (-)','Interpreter','latex');
        ylabel('Solution, x(t) (-)','Interpreter','latex');
    
        set(gca,'FontSize',13,'TickLabelInterpreter','latex');
    
        legend('Interpreter','latex','FontSize',11, 'Location','eastoutside');
    
        xlim([0,20]);
        grid on
        box on
        hold off
    end
    
    sgtitle(sprintf('Integration Stability: h_{ref} = %.2f',h_ref), 'Interpreter','latex','FontSize',18);

    filename = sprintf('integration_stability_%.2f.png',h_ref);
    exportgraphics(gcf,filename,'Resolution',600);
end