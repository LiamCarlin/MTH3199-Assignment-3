h = logspace(-5,1,100);
t = 0.492;

func = @(t,X) -5*X + 5*cos(t) - sin(t);
XA = cos(t);

change = zeros(size(h));
euler_error = zeros(size(h));
midpoint_error = zeros(size(h));

for i = 1:length(h)
    exact = cos(t+h(i));

    [XE,~] = forward_euler_step(func,t,XA,h(i));
    [XM,~] = explicit_midpoint_step(func,t,XA,h(i));

    change(i) = abs(exact-XA);
    euler_error(i) = abs(XE-exact);
    midpoint_error(i) = abs(XM-exact);
end

use = h >= 0.002 & h <= 0.02;
h_fit = h(use);

fit_change = polyfit(log10(h_fit),log10(change(use)),1);
fit_euler = polyfit(log10(h_fit),log10(euler_error(use)),1);
fit_midpoint = polyfit(log10(h_fit),log10(midpoint_error(use)),1);

figure();

loglog(h,change,'k.', h,euler_error,'r.', h,midpoint_error,'b.','MarkerSize',10);
hold on

h_line = logspace(-5,log10(0.02),100);

loglog(h_line,10.^polyval(fit_change,log10(h_line)),'k--', h_line,10.^polyval(fit_euler,log10(h_line)),'r--', h_line,10.^polyval(fit_midpoint,log10(h_line)),'b--', 'LineWidth',2);

xlabel('Step size, h (-)','Interpreter','latex');
ylabel('Local error or analytical change (-)','Interpreter','latex');
title('Local Error Scaling: Explicit Methods','Interpreter','latex');

legend('Analytical change','Forward Euler','Explicit midpoint', 'Analytical change fit','Euler fit','Midpoint fit', 'Interpreter','latex','Location','eastoutside','FontSize',12);

set(gca,'FontSize',16,'TickLabelInterpreter','latex');
hold off

exportgraphics(gcf,'local_error_explicit_with_fits.png', 'Resolution',600);